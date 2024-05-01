# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authenticate_request!
    Iam::Session::Validate
      .call(authorization: request.headers["Authorization"])
      .on_failure do
        render json: { errors: "Invalid token" }, status: :unauthorized
      end
  end
end
