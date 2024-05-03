# frozen_string_literal: true

module Wip
  class Goals::Find < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate :id, to: :form

    def execute
      if (goal = Goal.find_by(id:))
        Response.success(goal.to_struct)
      else
        Response.failure(
          CommandHandler::Errors::RecordNotFoundError
            .build(form:)
        )
      end
    end
  end
end
