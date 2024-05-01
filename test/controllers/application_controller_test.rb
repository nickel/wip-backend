# frozen_string_literal: true

require "test_helper"

class ApplicationControllerTest < ActionController::TestCase
  class DummyController < ApplicationController
    before_action :authenticate_request!

    def index
    end
  end

  tests DummyController

  test "should authorize a request with a valid token" do
    with_dummy_routing do
      token = Iam::Session::Create
        .call(username: "test", password: "test")
        .value[:token]

      @request.headers["Authorization"] = "Bearer #{token}"

      get :index
      assert_response :success
    end
  end

  test "should NOT authorize a request with an invalid token" do
    with_dummy_routing do
      @request.headers["Authorization"] = "Bearer invalid"

      get :index
      assert_response :unauthorized
    end
  end

  test "should NOT authorize a request with no token" do
    with_dummy_routing do
      get :index
      assert_response :unauthorized
    end
  end

  private

  def with_dummy_routing
    with_routing do |set|
      set.draw do
        resources :dummy, controller: "application_controller_test/dummy"
      end

      yield
    end
  end
end
