# frozen_string_literal: true

require "test_helper"

module Wip
  class Projects::FindTest < ActiveSupport::TestCase
    test "finds a project" do
      project = Factory.generate_project

      response = Projects::Find.call(id: project.id)

      assert response.success?

      assert_equal project.id, response.value.id
    end

    test "does not find a project when the id does not exist" do
      response = Projects::Find.call(id: -1)

      assert response.failure?
      assert_equal CommandHandler::Errors::RecordNotFoundError, response.value.class
    end

    test "when inputs are not valid" do
      response = Projects::Find.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
