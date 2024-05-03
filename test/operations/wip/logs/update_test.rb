# frozen_string_literal: true

require "test_helper"

module Wip
  class Logs::UpdateTest < ActiveSupport::TestCase
    test "updates a log with the proper values" do
      log = Factory.generate_log

      response = Logs::Update
        .call(
          id: log.id,
          content: "My wonderful content - Updated"
        )

      assert response.success?

      assert_equal log.id, response.value.id
      assert_equal "My wonderful content - Updated", response.value.content
    end
  end
end
