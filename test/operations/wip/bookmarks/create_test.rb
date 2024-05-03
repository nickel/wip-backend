# frozen_string_literal: true

require "test_helper"

module Wip
  class Bookmarks::CreateTest < ActiveSupport::TestCase
    test "creates a bookmark with the proper values" do
      response = Bookmarks::Create.call(**required_data)

      assert response.success?

      log = response.value

      assert_equal "My wonderful link", log.title
      assert_equal "Lorem ipsum", log.description
      assert_equal "https://google.es", log.url
    end

    test "creates a log without a required value" do
      required_data.each_key do |key|
        response = Bookmarks::Create.call(**required_data.except(key))

        assert response.failure?
        assert response.value.data.errors.key?(key)
      end
    end

    private

    def required_data(custom = {})
      {
        title: "My wonderful link",
        description: "Lorem ipsum",
        url: "https://google.es"
      }.merge(custom)
    end
  end
end
