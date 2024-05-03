# frozen_string_literal: true

module Wip
  class Projects::FindAll < CommandHandler::Command
    def execute
      Response.success(Project.all.map(&:to_struct))
    end
  end
end
