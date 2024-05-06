# frozen_string_literal: true

module Api
  module V1
    class GoalsControllerTest < ActionDispatch::IntegrationTest
      test "should list goals" do
        3.times { Factory.generate_goal }

        get api_v1_goals_url

        assert_response :success

        goals = JSON.parse(response.body)["goals"]

        assert_equal 3, goals.length
      end

      test "should create a goal" do
        post(api_v1_goals_url, params:, headers:)

        assert_response :success
      end

      test "should not create a goal with invalid input" do
        post(api_v1_goals_url, params: { goal: { title: "" } }, headers:)

        assert_response :unprocessable_entity
      end

      test "should not be authorized to create a goal" do
        post(api_v1_goals_url, params:)

        assert_response :unauthorized
      end

      private

      def params
        { goal: { title: "a title", description: "a description" } }
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
