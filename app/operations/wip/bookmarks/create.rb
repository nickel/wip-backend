# frozen_string_literal: true

module Wip
  class Bookmarks::Create < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :title, :string
      attribute :description, :string
      attribute :url, :string

      validates :title, :description, :url, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Bookmark
        .new(title:, description:, url:)
        .save_with_response
        .and_then { |bookmark| Response.success(bookmark.to_struct) }
    end
  end
end
