# frozen_string_literal: true

module Projects
  class Project < ApplicationRecord
    TYPES = %w(service library).freeze

    def to_struct
      CustomStruct
        .new(attributes)
    end
  end
end
