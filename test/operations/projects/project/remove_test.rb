# frozen_string_literal: true

require "test_helper"

module Projects
  class Project::RemoveTest < ActiveSupport::TestCase
    test "removes a project" do
      project = Factory.generate_project

      response = Project::Remove.call(id: project.id)

      assert response.success?
      assert Project::Find.call(id: project.id).failure?
    end

    test "when inputs are not valid" do
      response = Project::Remove.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
