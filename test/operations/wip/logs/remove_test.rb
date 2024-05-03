# frozen_string_literal: true

require "test_helper"

module Wip
  class Logs::RemoveTest < ActiveSupport::TestCase
    test "removes a log" do
      log = Factory.generate_log

      response = Logs::Remove.call(id: log.id)

      assert response.success?
      assert Logs::Find.call(id: log.id).failure?
    end

    test "when inputs are not valid" do
      response = Logs::Remove.call

      assert response.failure?
      assert_equal CommandHandler::Errors::InvalidInputError, response.value.class
    end
  end
end
