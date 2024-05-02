# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy

  def self.parser(tags)
    if tags.is_a?(String)
      (tags || "")
        .split(",")
        .map(&:strip)
    else
      tags
    end
  end
end
