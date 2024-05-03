# frozen_string_literal: true

module Wip
  class Goals::Update < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :id, :string
      attribute :title, :string
      attribute :description, :string

      validates :id, :title, :description, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Goal
        .find_by(id:)
        .update_with_response(title:, description:)
    end
  end
end
