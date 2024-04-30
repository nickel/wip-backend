# frozen_string_literal: true

module Projects
  class Project::Update < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer
      attribute :name, :string
      attribute :description, :string
      attribute :project_type, :string
      attribute :reference_url, :string

      validates :id, :name, :description, :project_type, presence: true
      validates :project_type, inclusion: { in: Project::TYPES }
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Project::Find
        .call(id:)
        .and_then do
          Project
            .find_by(id:)
            .update_with_response(name:, description:, project_type:, reference_url:)
            .and_then do |project|
              Response.success(project.to_struct)
            end
        end
    end
  end
end
