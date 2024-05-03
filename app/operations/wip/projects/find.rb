# frozen_string_literal: true

module Wip
  class Projects::Find < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      if (project = Project.find_by(id:))
        Response.success(project.to_struct)
      else
        Response.failure(
          CommandHandler::Errors::RecordNotFoundError
            .build(form:)
        )
      end
    end
  end
end
