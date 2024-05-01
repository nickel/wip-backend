# frozen_string_literal: true

module Iam
  class Session::Validate < CommandHandler::Command
    class Form
      include CommandHandler::Form

      attribute :authorization, :string

      validates :authorization, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      jwt_decode(authorization.split(" ").last)

      Response.success(true)
    rescue JWT::DecodeError, JWT::VerificationError
      Response.failure(true)
    end

    private

    def jwt_decode(token)
      JWT.decode(
        token,
        Rails.application.credentials.secret_key_base,
        true,
        { algorithm: "HS256" }
      )[0]
    end
  end
end
