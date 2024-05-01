# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authenticate_request!
    # Extract token from "Bearer <token>" format
    authorization = request
      .headers
      .fetch("Authorization", "")
      .split(" ")
      .last

    Iam::Session::Validate
      .call(authorization:)
      .on_failure do
        render json: { errors: "Invalid token" }, status: :unauthorized
      end
  end
end
