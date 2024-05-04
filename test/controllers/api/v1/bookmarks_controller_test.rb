# frozen_string_literal: true

module Api
  module V1
    class BookmarksControllerTest < ActionDispatch::IntegrationTest
      test "should create a bookmark" do
        post(api_v1_bookmarks_url, params:, headers:)

        assert_response :success
      end

      test "should not create a bookmark with invalid input" do
        post(api_v1_bookmarks_url, params: { bookmark: { title: "" } }, headers:)

        assert_response :unprocessable_entity
      end

      test "should not be authorized to create a bookmark" do
        post(api_v1_bookmarks_url, params:)

        assert_response :unauthorized
      end

      private

      def params
        { bookmark: { title: "a title", description: "a description", url: "https://google.es" } }
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
