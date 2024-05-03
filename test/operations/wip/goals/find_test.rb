# frozen_string_literal: true

require "test_helper"

module Wip
  class Goals::FindTest < ActiveSupport::TestCase
    test "finds a goal" do
      goal = Factory.generate_goal

      response = Goals::Find.call(id: goal.id)

      assert response.success?

      assert_equal goal.id, response.value.id
    end

    test "does not find a goal when the id does not exist" do
      response = Goals::Find.call(id: -1)

      assert response.failure?
      assert_equal CommandHandler::Errors::RecordNotFoundError, response.value.class
    end

    test "when inputs are not valid" do
      response = Goals::Find.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
