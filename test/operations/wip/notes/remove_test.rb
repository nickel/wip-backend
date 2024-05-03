# frozen_string_literal: true

require "test_helper"

module Wip
  class Notes::RemoveTest < ActiveSupport::TestCase
    test "note is remove" do
      note = Factory.generate_note

      response = Notes::Remove.call(id: note.id)

      assert response.success?
      assert Notes::Find.call(id: note.id).failure?
    end

    test "when inputs are not valid" do
      response = Notes::Remove.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
