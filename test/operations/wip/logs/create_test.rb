# frozen_string_literal: true

require "test_helper"

module Wip
  class Logs::CreateTest < ActiveSupport::TestCase
    test "creates a log with the proper values" do
      response = Logs::Create.call(**required_data)

      assert response.success?

      log = response.value

      assert_equal "My wonderful log", log.content
    end

    test "creates a log without a required value" do
      required_data.each_key do |key|
        response = Logs::Create.call(**required_data.except(key))

        assert response.failure?
        assert response.value.data.errors.key?(key)
      end
    end

    private

    def required_data(custom = {})
      {
        content: "My wonderful log"
      }.merge(custom)
    end
  end
end
