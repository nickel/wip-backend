# frozen_string_literal: true

module Iam
  class Session::Create < CommandHandler::Command
    SESSION_EXPIRATION_TIME = 30.minutes

    class Form
      include CommandHandler::Form

      attribute :username, :string
      attribute :password, :string

      validates :username, :password, presence: true
    end

    delegate(*Form.new.attributes.keys, to: :form)

    def execute
      if username == Rails.configuration.x.auth_user_name &&
         password == Rails.configuration.x.auth_user_pass
        Response.success(token: jwt_encode(exp: (Time.current + SESSION_EXPIRATION_TIME).to_i))
      else
        Response.failure(message: "Unauthorized")
      end
    end

    private

    def jwt_encode(payload)
      JWT.encode(
        payload,
        Rails.configuration.secret_key_base,
        "HS256"
      )
    end
  end
end
