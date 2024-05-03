# frozen_string_literal: true

require "test_helper"

module Wip
  class Goals::UpdateTest < ActiveSupport::TestCase
    test "updates a goal with the proper values" do
      goal = Factory.generate_goal

      response = Goals::Update
        .call(
          id: goal.id,
          title: "My wonderful title - Updated",
          description: "Lorem ipsum - Updated"
        )

      assert response.success?

      assert_equal goal.id, response.value.id
      assert_equal "My wonderful title - Updated", response.value.title
      assert_equal "Lorem ipsum - Updated", response.value.description
    end
  end
end
