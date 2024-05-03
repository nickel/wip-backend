# frozen_string_literal: true

require "test_helper"

module Wip
  class Projects::FindAllTest < ActiveSupport::TestCase
    test "find all projects" do
      3.times { Factory.generate_project }

      response = Projects::FindAll.call

      assert response.success?

      assert_equal 3, response.value.length
    end
  end
end
