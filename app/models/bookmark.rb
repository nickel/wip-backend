# frozen_string_literal: true

class Bookmark < ApplicationRecord
  def to_struct
    CustomStruct.new(
      attributes
    )
  end
end
