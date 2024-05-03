# frozen_string_literal: true

module Wip
  class Bookmarks::Remove < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :integer

      validates :id, presence: true
    end

    delegate :id, to: :form

    def execute
      Bookmarks::Find
        .call(id:)
        .and_then do |bookmark|
          Response.success(
            Bookmark
              .destroy(bookmark.id)
              .to_struct
          )
        end
    end
  end
end
