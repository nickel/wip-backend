# frozen_string_literal: true

require "test_helper"

module Wip
  class Bookmarks::FindTest < ActiveSupport::TestCase
    test "finds a bookmark" do
      bookmark = Factory.generate_bookmark

      response = Bookmarks::Find.call(id: bookmark.id)

      assert response.success?

      assert_equal bookmark.id, response.value.id
    end

    test "does not find a bookmark when the id does not exist" do
      response = Bookmarks::Find.call(id: -1)

      assert response.failure?
      assert_equal CommandHandler::Errors::RecordNotFoundError, response.value.class
    end

    test "when inputs are not valid" do
      response = Bookmarks::Find.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
