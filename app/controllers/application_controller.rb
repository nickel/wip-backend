# frozen_string_literal: true

class ApplicationController < ActionController::API
  module ExceptionHandler
    class InvalidToken < RuntimeError; end
  end

  private

  def authenticate_request!
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      jwt_decode(header)
    rescue JWT::DecodeError, JWT::VerificationError
      render json: { errors: "Invalid token" }, status: :unauthorized
    end
  end

  def jwt_decode(token)
    JWT.decode(
      token, Rails.application.credentials.secret_key_base, true, { algorithm: "HS256" }
    )[0]
  end
end
