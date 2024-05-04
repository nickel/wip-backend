# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        response = Iam::Session::Create
          .call(username: params[:username], password: params[:password])

        if response.success?
          render json: { token: response.value[:token] }, status: :ok
        else
          render json: { error: response.value[:message] }, status: :unauthorized
        end
      end
    end
  end
end
