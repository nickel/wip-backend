# frozen_string_literal: true

require "test_helper"

module Iam
  class Session::CreateTest < ActiveSupport::TestCase
    test "should create a session with the proper credentials" do
      response = Session::Create.call(username: "test", password: "test")

      assert response.success?
      assert response.value[:token].present?
    end

    test "should NOT create a session with invalid credentials" do
      response = Session::Create.call(username: "fail", password: "fail")

      assert response.failure?
      assert_equal "Unauthorized", response.value[:message]
    end

    test "should require username and password parameters" do
      response = Session::Create.call

      assert response.failure?
      assert response.value.data.errors.key?(:username)
      assert response.value.data.errors.key?(:password)
    end
  end
end
