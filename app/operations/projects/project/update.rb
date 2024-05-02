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
      attribute :tags, default: []

      validates :id, :name, :description, :project_type, presence: true
      validates :project_type, inclusion: { in: Project::TYPES }

      def tags=(tags)
        super(Tag.parser(tags))
      end
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      find_project.and_then do
        create_or_update_tags.and_then do |tags|
          update_project(tags:).and_then do |project|
            Response.success(project.to_struct)
          end
        end
      end
    end

    def find_project
      Project::Find.call(id:)
    end

    def create_or_update_tags
      Response.success(
        tags.map { |name| Tag.find_or_create_by(name:) }
      )
    end

    def update_project(tags:)
      Project
        .find_by(id:)
        .update_with_response(name:, description:, project_type:, reference_url:, tags:)
    end
  end
end
