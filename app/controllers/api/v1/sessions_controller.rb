# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        Iam::Session::Create
          .call(username: params[:username], password: params[:password])
          .on_failure { |response| render json: { error: response[:message] }, status: :unauthorized }
          .and_then   { |response| render json: { token: response[:token] },   status: :ok }
      end
    end
  end
end
