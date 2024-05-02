# frozen_string_literal: true

module Projects
  class Project::Create < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :name, :string
      attribute :description, :string
      attribute :project_type, :string
      attribute :reference_url, :string
      attribute :tags, default: []

      validates :name, :description, :project_type, presence: true
      validates :project_type, inclusion: { in: Project::TYPES }

      def tags=(tags)
        super(Tag.parser(tags))
      end
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      ActiveRecord::Base.transaction do
        create_tags.and_then do |tags|
          create_project(tags:).and_then do |project|
            Response.success(project.to_struct)
          end
        end
      end
    end

    def create_tags
      Response.success(
        tags.map { |name| Tag.create(name:) }
      )
    end

    def create_project(tags:)
      Project
        .new(name:, description:, project_type:, reference_url:, tags:)
        .save_with_response
    end
  end
end
