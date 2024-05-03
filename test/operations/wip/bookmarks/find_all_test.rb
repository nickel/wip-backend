# frozen_string_literal: true

require "test_helper"

module Wip
  class Bookmarks::FindAllTest < ActiveSupport::TestCase
    test "find all bookmarks" do
      3.times { Factory.generate_bookmark }

      response = Bookmarks::FindAll.call

      assert response.success?

      assert_equal 3, response.value.length
    end
  end
end
