# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings

    scope :tagged_with, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }).distinct }
  end

  def tag_list
    tags.map(&:name)
  end

  module ClassMethods
    def tags
      Tag.joins(:taggings)
        .where(taggings: { taggable_type: name })
        .order(:name)
        .map(&:name)
    end
  end
end
