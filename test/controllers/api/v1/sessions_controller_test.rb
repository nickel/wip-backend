# frozen_string_literal: true

module Api
  module V1
    class SessionsControllerTest < ActionDispatch::IntegrationTest
      test "should authenticate user" do
        post api_v1_login_url(username: "test", password: "test")
        assert_response :success
      end

      test "should not authenticate user" do
        post api_v1_login_url(username: "fail", password: "fail")
        assert_response :unauthorized
      end
    end
  end
end
