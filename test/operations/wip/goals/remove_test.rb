# frozen_string_literal: true

require "test_helper"

module Wip
  class Goals::RemoveTest < ActiveSupport::TestCase
    test "removes a goal" do
      goal = Factory.generate_goal

      response = Goals::Remove.call(id: goal.id)

      assert response.success?
      assert Goals::Find.call(id: goal.id).failure?
    end

    test "when inputs are not valid" do
      response = Goals::Remove.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
