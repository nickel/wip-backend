# frozen_string_literal: true

class Note < ApplicationRecord
  include Taggable

  def intro
    return "" unless content.present?

    content
      .split("\n")
      .first
  end

  def to_struct
    CustomStruct.new(
      attributes
        .merge(intro:, tags: tag_list)
    )
  end

  def to_param
    [id, title.parameterize].join("-")
  end
end
