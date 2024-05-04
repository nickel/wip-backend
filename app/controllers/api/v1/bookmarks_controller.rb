# frozen_string_literal: true

module Api
  module V1
    class BookmarksController < ApplicationController
      before_action :authenticate_request!, only: %w(create)

      def create
        response = Wip::Bookmarks::Create.call(**input_data_for_create)

        if response.success?
          render json: response.value.to_h, status: :created
        else
          render json: response.value.data.errors, status: :unprocessable_entity
        end
      end

      private

      def input_data_for_create
        params
          .require(:bookmark)
          .permit(:title, :description, :url)
      end
    end
  end
end
