# frozen_string_literal: true

require "test_helper"

module Wip
  class Projects::RemoveTest < ActiveSupport::TestCase
    test "removes a project" do
      project = Factory.generate_project

      response = Projects::Remove.call(id: project.id)

      assert response.success?
      assert Projects::Find.call(id: project.id).failure?
    end

    test "when inputs are not valid" do
      response = Projects::Remove.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
