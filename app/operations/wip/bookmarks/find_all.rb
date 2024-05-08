# frozen_string_literal: true

module Wip
  class Bookmarks::FindAll < CommandHandler::Command
    def execute
      Response.success(
        Bookmark
          .order("created_at DESC")
          .map(&:to_struct)
      )
    end
  end
end
