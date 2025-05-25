# frozen_string_literal: true

require_relative '../base'
require_relative 'models/response'
require_relative 'models/hotel'

module HotelBedsClient
  module HotelsList
    class Main < HotelBedsClient::Base
      def call
        set_options
        make_request
        handle_response
      end

      private

      def set_options
        @options = {
          destination_code: destination_code,
          country_code: country_code,
          codes: codes,
          include_hotels: include_hotels,
          fields: fields,
          language: language,
          from2: from,
          to: to,
          use_secondary_language: use_secondary_language,
          last_update_time: to_safe_date(last_update_time),
          pms_room_code: pms_room_code
        }.compact
      end

      def make_request
        @response = get_request(options: @options)
      end

      def handle_response
        HotelBedsClient::HotelsList::Models::Response.new(@response)
      end

      # API defaults

      def api_type
        'hotel-content-api'
      end

      def api_version
        '1.0'
      end

      def request_url
        'hotels'
      end
    end
  end
end
