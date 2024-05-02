# frozen_string_literal: true

module Projects
  class Project < ApplicationRecord
    include Taggable

    TYPES = %w(service library).freeze

    def to_struct
      CustomStruct
        .new(attributes.merge(tags: tag_list))
    end
  end
end
