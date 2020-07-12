module Api
  module V1
    class ConversionController < ApplicationController
      def create
        if permitted_params[:data].nil?
          render json: { message: 'There was no data at all' }, status: :bad_request
        elsif permitted_params[:data]
          render json: { message: 'There was no valid data file' }, status: :unsupported_media_type
        end
      end

      def show(uuid)

      end

      private

      def permitted_params
        params.permit(:name, :data)
      end
    end
  end
end
