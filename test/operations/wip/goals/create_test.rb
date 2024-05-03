# frozen_string_literal: true

require "test_helper"

module Wip
  class Goals::CreateTest < ActiveSupport::TestCase
    test "creates a goal with the proper values" do
      response = Goals::Create.call(**required_data)

      assert response.success?

      goal = response.value

      assert_equal "My wonderful goal", goal.title
      assert_equal "Lorem ipsum", goal.description
    end

    test "creates a log without a required value" do
      required_data.each_key do |key|
        response = Goals::Create.call(**required_data.except(key))

        assert response.failure?
        assert response.value.data.errors.key?(key)
      end
    end

    private

    def required_data(custom = {})
      {
        title: "My wonderful goal",
        description: "Lorem ipsum"
      }.merge(custom)
    end
  end
end
