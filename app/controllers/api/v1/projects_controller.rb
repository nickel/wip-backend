# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_request!, only: %w(create)

      def index
        response = Wip::Projects::FindAll.call

        render json: { projects: response.value }, status: :ok
      end

      def create
        response = Wip::Projects::Create.call(**input_data_for_create)

        if response.success?
          render json: response.value, status: :created
        else
          render json: response.value.data.errors, status: :unprocessable_entity
        end
      end

      private

      def input_data_for_create
        params
          .require(:project)
          .permit(:name, :description, :project_type, :reference_url)
      end
    end
  end
end
