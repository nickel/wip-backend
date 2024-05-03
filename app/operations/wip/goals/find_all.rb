# frozen_string_literal: true

module Wip
  class Goals::FindAll < CommandHandler::Command
    def execute
      Response.success(Goal.all.map(&:to_struct))
    end
  end
end
