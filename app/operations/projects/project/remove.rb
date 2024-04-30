# frozen_string_literal: true

module Projects
  class Project::Remove < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Project::Find
        .call(id:)
        .and_then do |project|
          Response.success(
            Project
              .destroy(project.id)
              .to_struct
          )
        end
    end
  end
end
