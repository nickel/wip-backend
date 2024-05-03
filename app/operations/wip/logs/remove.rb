# frozen_string_literal: true

module Wip
  class Logs::Remove < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate :id, to: :form

    def execute
      Logs::Find
        .call(id:)
        .and_then do |log|
          Response.success(
            Log
              .destroy(log.id)
              .to_struct
          )
        end
    end
  end
end
