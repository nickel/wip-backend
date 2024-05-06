# frozen_string_literal: true

module Api
  module V1
    class ProjectsControllerTest < ActionDispatch::IntegrationTest
      test "should list projects" do
        3.times { Factory.generate_project }

        get api_v1_projects_url

        assert_response :success

        projects = JSON.parse(response.body)["projects"]

        assert_equal 3, projects.length
      end

      test "should create a project" do
        post(api_v1_projects_url, params:, headers:)

        assert_response :success
      end

      test "should not create a project with invalid input" do
        post(api_v1_projects_url, params: { project: { name: "" } }, headers:)

        assert_response :unprocessable_entity
      end

      test "should not be authorized to create a project" do
        post(api_v1_projects_url, params:)

        assert_response :unauthorized
      end

      private

      def params
        {
          project: {
            name: "a name",
            description: "a description",
            project_type: "service",
            tags: "foo, bar",
            reference_url: "https://google.es"
          }
        }
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
