# frozen_string_literal: true

module Api
  module V1
    class NotesController < ApplicationController
      before_action :authenticate_request!, only: %w(create)

      def index
        response = Wip::Notes::FindAll.call

        render json: { notes: response.value }, status: :ok
      end

      def create
        response = Wip::Notes::Create.call(**input_data_for_create)

        if response.success?
          render json: response.value, status: :created
        else
          render json: response.value.data.errors, status: :unprocessable_entity
        end
      end

      private

      def input_data_for_create
        params
          .require(:note)
          .permit(:title, :content, :tags)
      end
    end
  end
end
