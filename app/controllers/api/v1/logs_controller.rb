# frozen_string_literal: true

module Api
  module V1
    class LogsController < ApplicationController
      before_action :authenticate_request!, only: %w(create)

      def index
        response = Wip::Logs::FindAll.call

        render json: { logs: response.value }, status: :ok
      end

      def create
        response = Wip::Logs::Create.call(**input_data_for_create)

        if response.success?
          render json: response.value, status: :created
        else
          render json: response.value.data.errors, status: :unprocessable_entity
        end
      end

      private

      def input_data_for_create
        params
          .require(:log)
          .permit(:content)
      end
    end
  end
end
