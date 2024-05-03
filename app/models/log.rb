# frozen_string_literal: true

class Log < ApplicationRecord
  def to_struct
    CustomStruct.new(
      attributes
    )
  end
end
