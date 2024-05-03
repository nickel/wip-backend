# frozen_string_literal: true

module Wip
  class Logs::Update < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :string
      attribute :content, :string

      validates :id, :content, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Log
        .find_by(id:)
        .update_with_response(content:)
    end
  end
end
