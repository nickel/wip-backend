# frozen_string_literal: true

require "test_helper"

module Projects
  class Project::CreateTest < ActiveSupport::TestCase
    test "creates a project with the proper values" do
      response = Project::Create.call(**required_data)

      assert response.success?

      project = response.value

      assert_equal "My wonderful project", project.name
      assert_equal "Lorem ipsum dolor sit amet", project.description
      assert_equal "service", project.project_type
    end

    test "creates a project without a required value" do
      required_data.each_key do |key|
        response = Project::Create.call(**required_data.except(key))

        assert response.failure?
        assert response.value.data.errors.key?(key)
      end
    end

    test "creates a project with a not proper type value" do
      response = Project::Create.call(**required_data(project_type: "invent"))

      assert response.failure?
      assert response.value.data.errors.key?(:project_type)
      assert_equal :inclusion, response.value.data.errors.first.type
    end

    private

    def required_data(custom = {})
      {
        name: "My wonderful project",
        description: "Lorem ipsum dolor sit amet",
        project_type: "service"
      }.merge(custom)
    end
  end
end
