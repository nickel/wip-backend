# frozen_string_literal: true

module Wip
  class Notes::Remove < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate :id, to: :form

    def execute
      Notes::Find
        .call(id:)
        .and_then do |note|
          Response.success(
            Note
              .destroy(note.id)
              .to_struct
          )
        end
    end
  end
end
