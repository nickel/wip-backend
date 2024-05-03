# frozen_string_literal: true

require "test_helper"

module Wip
  class Logs::FindAllTest < ActiveSupport::TestCase
    test "find all logs" do
      3.times { Factory.generate_log }

      response = Logs::FindAll.call

      assert response.success?

      assert_equal 3, response.value.length
    end
  end
end
