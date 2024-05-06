# frozen_string_literal: true

module Api
  module V1
    class GoalsController < ApplicationController
      before_action :authenticate_request!, only: %w(create)

      def index
        response = Wip::Goals::FindAll.call

        render json: { goals: response.value }, status: :ok
      end

      def create
        response = Wip::Goals::Create.call(**input_data_for_create)

        if response.success?
          render json: response.value, status: :created
        else
          render json: response.value.data.errors, status: :unprocessable_entity
        end
      end

      private

      def input_data_for_create
        params
          .require(:goal)
          .permit(:title, :description)
      end
    end
  end
end
