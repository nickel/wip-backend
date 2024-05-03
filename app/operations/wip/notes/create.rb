# frozen_string_literal: true

module Wip
  class Notes::Create < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :title, :string
      attribute :content, :string
      attribute :private, :boolean, default: true
      attribute :tags, default: []

      validates :title, presence: true

      def tags=(tags)
        super(Tag.parser(tags))
      end
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      ActiveRecord::Base.transaction do
        create_tags.and_then do |tags|
          create_note(tags:).and_then do |note|
            Response.success(note.to_struct)
          end
        end
      end
    end

    private

    def create_tags
      Response.success(
        tags.map { |name| Tag.find_or_create_by(name:) }
      )
    end

    def create_note(tags:)
      Note
        .new(title:, content:, private:, tags:)
        .save_with_response
    end
  end
end
