# frozen_string_literal: true

module Wip
  class Notes::FindAll < CommandHandler::Command
    BY_VISIBILITY_FILTERS = %w(public private).freeze

    class Form
      include CommandHandler::Form

      attribute :by_visibility, :string, default: "public"

      validates :by_visibility, inclusion: { in: BY_VISIBILITY_FILTERS }
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def call
      Response.success(
        find_all.map(&:to_struct)
      )
    end

    private

    def find_all
      notes = by_visibility == "private" ? Note.all : Note.where(private: false)

      notes.reorder(created_at: :desc)
    end
  end
end
