# frozen_string_literal: true

module Wip
  class Goals::Remove < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate :id, to: :form

    def execute
      Goals::Find
        .call(id:)
        .and_then do |goal|
          Response.success(
            Goal
              .destroy(goal.id)
              .to_struct
          )
        end
    end
  end
end
