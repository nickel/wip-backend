# frozen_string_literal: true

require "test_helper"

module Wip
  class Bookmarks::UpdateTest < ActiveSupport::TestCase
    test "updates a bookmark with the proper values" do
      bookmark = Factory.generate_bookmark

      response = Bookmarks::Update
        .call(
          id: bookmark.id,
          title: "My wonderful title - Updated",
          description: "Lorem ipsum - Updated",
          url: "https://updated.com"
        )

      assert response.success?

      assert_equal bookmark.id, response.value.id
      assert_equal "My wonderful title - Updated", response.value.title
      assert_equal "Lorem ipsum - Updated", response.value.description
      assert_equal "https://updated.com", response.value.url
    end
  end
end
