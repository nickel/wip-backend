# frozen_string_literal: true

require "test_helper"

module Wip
  class Notes::UpdateTest < ActiveSupport::TestCase
    test "note update with the proper values" do
      note = Factory.generate_note

      response = Notes::Update
        .call(
          id: note.id,
          title: "My wonderful note - Updated",
          content: "Lorem ipsum dolor sit amet - Updated",
          tags: "note, first, updated"
        )

      assert response.success?

      note = response.value

      assert_equal "My wonderful note - Updated", note.title
      assert_equal "Lorem ipsum dolor sit amet - Updated", note.content
      assert_equal %w(note first updated).sort, note.tags.sort
    end
  end
end
