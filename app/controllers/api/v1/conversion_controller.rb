module Api
  module V1
    class ConversionController < ApplicationController
      VALID_FORMATS = %w[step iges stl obj]

      def create
        @response = Hash.new
        @response['errors'] = []

        # Thats not a good pattern. This is business logic in controller, but the damn jbuilder didnt want to work
        # So thats a TODO to refact
        if permitted_params[:data].nil?
          @response['status'] ||= :bad_request
          @response['errors'] << { message: 'There was no data at all' }
        elsif VALID_FORMATS.exclude? permitted_params[:target]
          @response['status'] ||= :unsupported_media_type
          @response['errors'] << { message: "There was no valid target format (#{VALID_FORMATS})" }
        elsif permitted_params[:data].split(';').first != 'data:document/shapr'
          @response['status'] ||= :unsupported_media_type
          @response['errors'] << { message: 'There was no valid data file' }
        else
          @response['status'] = :ok
          @response['message'] = "The conversion is queued"
          @response['uuid'] = SecureRandom.uuid
          # enqueue the job
        end

        render json: @response, status: @response['status']
      end

      def show

      end

      private

      def permitted_params
        params.permit(:name, :data, :target)
      end
    end
  end
end
