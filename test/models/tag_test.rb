# frozen_string_literal: true

require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "parsing tags when string" do
    ["foo, bar", "foo,bar", "foo, bar ", "FoO, BaR"].each do |tags|
      assert_equal %w(foo bar).sort, Tag.parser(tags).sort
    end
  end

  test "parsing tags when array" do
    assert_equal %w(foo bar).sort, Tag.parser(%w(foo bar)).sort
  end
end
