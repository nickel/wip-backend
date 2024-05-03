# frozen_string_literal: true

require "test_helper"

module Wip
  class Notes::FindAllTest < ActiveSupport::TestCase
    test "public notes are found" do
      3.times { Factory.generate_note(private: false) }

      response = Notes::FindAll.call

      assert response.success?
      assert_equal 3, response.value.length
    end

    test "private notes are not found" do
      3.times { Factory.generate_note(private: true) }

      response = Notes::FindAll.call

      assert response.success?
      assert_equal 0, response.value.length
    end

    test "private notes are found" do
      3.times { Factory.generate_note(private: true) }

      response = Notes::FindAll.call(by_visibility: "private")

      assert response.success?
      assert_equal 3, response.value.length
    end
  end
end
