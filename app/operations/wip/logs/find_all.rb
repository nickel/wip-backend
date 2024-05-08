# frozen_string_literal: true

module Wip
  class Logs::FindAll < CommandHandler::Command
    def execute
      Response.success(
        Log
          .order("created_at DESC")
          .map(&:to_struct)
      )
    end
  end
end
