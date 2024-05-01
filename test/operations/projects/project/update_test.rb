# frozen_string_literal: true

require "test_helper"

module Projects
  class Project::UpdateTest < ActiveSupport::TestCase
    test "updates a project with the proper values" do
      project = Factory.generate_project

      response = Project::Update
        .call(
          id: project.id,
          name: "My wonderful project - Updated",
          description: "Lorem ipsum dolor sit amet - Updated",
          project_type: "service"
        )

      assert response.success?

      assert_equal project.id, response.value.id
      assert_equal "My wonderful project - Updated", response.value.name
      assert_equal "Lorem ipsum dolor sit amet - Updated", response.value.description
    end
  end
end