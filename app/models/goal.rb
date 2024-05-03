# frozen_string_literal: true

class Goal < ApplicationRecord
  def to_struct
    CustomStruct.new(
      attributes
    )
  end
end
