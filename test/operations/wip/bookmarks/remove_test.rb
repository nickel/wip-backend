# frozen_string_literal: true

require "test_helper"

module Wip
  class Bookmarks::RemoveTest < ActiveSupport::TestCase
    test "removes a bookmark" do
      bookmark = Factory.generate_bookmark

      response = Bookmarks::Remove.call(id: bookmark.id)

      assert response.success?
      assert Bookmarks::Find.call(id: bookmark.id).failure?
    end

    test "when inputs are not valid" do
      response = Bookmarks::Remove.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
