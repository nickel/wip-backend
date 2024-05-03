# frozen_string_literal: true

module Wip
  class Notes::Update < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :string
      attribute :title, :string
      attribute :content, :string
      attribute :private, :boolean, default: true
      attribute :tags, default: []

      validates :id, :title, presence: true

      def tags=(tags)
        super(Tag.parser(tags))
      end
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      find_note.and_then do
        create_or_update_tags.and_then do |tags|
          update_note(tags:).and_then do |note|
            Response.success(note.to_struct)
          end
        end
      end
    end

    def find_note
      Notes::Find.call(id:)
    end

    def create_or_update_tags
      Response.success(
        tags.map { |name| Tag.find_or_create_by(name:) }
      )
    end

    def update_note(tags:)
      Note
        .find_by(id:)
        .update_with_response(title:, content:, private:, tags:)
    end
  end
end
