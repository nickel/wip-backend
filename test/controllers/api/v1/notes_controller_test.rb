# frozen_string_literal: true

module Api
  module V1
    class NotesControllerTest < ActionDispatch::IntegrationTest
      test "should list notes" do
        3.times { Factory.generate_note(private: false) }

        get api_v1_notes_url

        assert_response :success

        notes = JSON.parse(response.body)["notes"]

        assert_equal 3, notes.length
      end

      test "should create a note" do
        post(api_v1_notes_url, params:, headers:)

        assert_response :success
      end

      test "should not create a note with invalid input" do
        post(api_v1_notes_url, params: { note: { title: "" } }, headers:)

        assert_response :unprocessable_entity
      end

      test "should not be authorized to create a note" do
        post(api_v1_notes_url, params:)

        assert_response :unauthorized
      end

      private

      def params
        { note: { title: "a title", content: "a content", tags: "foo, bar" } }
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
