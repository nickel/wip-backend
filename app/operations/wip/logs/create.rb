# frozen_string_literal: true

module Wip
  class Logs::Create < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :content, :string

      validates :content, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      Log
        .new(content:)
        .save_with_response
        .and_then { |log| Response.success(log.to_struct) }
    end
  end
end
