# frozen_string_literal: true

module Wip
  class Projects::FindAll < CommandHandler::Command
    class Form
      include CommandHandler::Form
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Response.success(Project.all.map(&:to_struct))
    end
  end
end
