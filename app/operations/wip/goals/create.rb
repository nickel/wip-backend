# frozen_string_literal: true

module Wip
  class Goals::Create < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :title, :string
      attribute :description, :string

      validates :title, :description, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Goal
        .new(title:, description:)
        .save_with_response
        .and_then { |goal| Response.success(goal.to_struct) }
    end
  end
end
