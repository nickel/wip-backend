# frozen_string_literal: true

module Api
  module V1
    class LogsControllerTest < ActionDispatch::IntegrationTest
      test "should list logs" do
        3.times { Factory.generate_log }

        get api_v1_logs_url

        assert_response :success

        logs = JSON.parse(response.body)["logs"]

        assert_equal 3, logs.length
      end

      test "should create a log" do
        post(api_v1_logs_url, params:, headers:)

        assert_response :success
      end

      test "should not create a log with invalid input" do
        post(api_v1_logs_url, params: { log: { title: "" } }, headers:)

        assert_response :unprocessable_entity
      end

      test "should not be authorized to create a log" do
        post(api_v1_logs_url, params:)

        assert_response :unauthorized
      end

      private

      def params
        { log: { content: "a content" } }
      end

      def headers
        { "Authorization" => "Bearer #{auth_token}" }
      end

      def auth_token
        Iam::Session::Create
          .call(username: "test", password: "test")
          .value[:token]
      end
    end
  end
end
