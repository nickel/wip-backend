# frozen_string_literal: true

module Wip
  class Bookmarks::Update < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :string
      attribute :title, :string
      attribute :description, :string
      attribute :url, :string

      validates :id, :title, :description, :url, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Bookmark
        .find_by(id:)
        .update_with_response(title:, description:, url:)
        .and_then { |bookmark| Response.success(bookmark.to_struct) }
    end
  end
end
