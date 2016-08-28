module Api
  module V1

    class OrdersController < ApplicationController
      before_action :authentification, :valid_date?

      def index
        date = Time.parse(params[:date]) rescue Time.now
        @orders = Order.up_to_date(date)
      end


      private


      def authentification
        api_key = ApiKey.active.find_by_access_token(params[:access_token])

        render_error!(:unauthorized) unless api_key.present?
      end

      def valid_date?
        render_error!(:bad_request) unless params[:date].nil? || (Time.parse(params[:date]) rescue false)
      end

      def render_error!(type)
        respond_to do |format|
          format.json do
            self.status = type
            self.response_body = JSON.pretty_generate({ error: error_text(type) })
          end
        end
      end

      def error_text(type)
        case type
        when :unauthorized then 'Access denied'
        when :bad_request then 'Wrong data'
        end
      end
    end

  end
end
