# frozen_string_literal: true

require "test_helper"

module Iam
  class Session::ValidateTest < ActiveSupport::TestCase
    test "should validate a session with the proper token" do
      authorization = Session::Create
        .call(username: "test", password: "test")
        .value[:token]

      response = Session::Validate.call(authorization:)

      assert response.success?
    end

    test "should NOT validate a session with invalid token" do
      response = Session::Validate.call(authorization: "invalid")

      assert response.failure?
    end

    test "should require authorization parameters" do
      response = Session::Validate.call

      assert response.failure?
      assert response.value.data.errors.key?(:authorization)
    end
  end
end
