# frozen_string_literal: true

require "test_helper"

module Wip
  class Goals::FindAllTest < ActiveSupport::TestCase
    test "find all goals" do
      3.times { Factory.generate_goal }

      response = Goals::FindAll.call

      assert response.success?

      assert_equal 3, response.value.length
    end
  end
end
