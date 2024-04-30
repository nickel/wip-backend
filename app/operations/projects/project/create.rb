# frozen_string_literal: true

module Projects
  class Project::Create < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :name, :string
      attribute :description, :string
      attribute :project_type, :string
      attribute :reference_url, :string

      validates :name, :description, :project_type, presence: true
      validates :project_type, inclusion: { in: Project::TYPES }
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Project
        .new(name:, description:, project_type:, reference_url:)
        .save_with_response
        .and_then do |project|
          Response.success(project.to_struct)
        end
    end
  end
end
