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
    with_routing do |set|
      set.draw do
        resources :dummy, controller: "application_controller_test/dummy"
      end

      begin
        token = Iam::Session::Create
          .call(username: "test", password: "test")
          .value[:token]

        @request.headers["Authorization"] = "Bearer #{token}"

        get :index
        assert_response :success
      end
    end
  end

  test "should NOT authorize a request with an invalid token" do
    with_routing do |set|
      set.draw do
        resources :dummy, controller: "application_controller_test/dummy"
      end

      begin
        token = Iam::Session::Create
          .call(username: "test", password: "test")
          .value[:token]

        @request.headers["Authorization"] = "Bearer invalid"

        get :index
        assert_response :unauthorized
      end
    end
  end
end
