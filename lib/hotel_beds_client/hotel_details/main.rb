# frozen_string_literal: true

require_relative '../base'
require_relative 'models/response'
require_relative 'models/hotel'

module HotelBedsClient
  module HotelDetails
    class Main < HotelBedsClient::Base
      # QUERY PARAMETERS
      # https://developer.hotelbeds.com/documentation/hotels/content-api/api-reference/#tag/Hotels/operation/hotelWithIdDetailsUsingGET
      #
      #   language
      # string
      # Example: language=CAS
      # The language code for the language in which you want the descriptions to be returned.
      # If language is not specified, English will be used as default language.
      #
      #   useSecondaryLanguage
      # boolean
      # Defines if you want to receive the descriptions in English if the description is not available in the language requested.

      def call
        set_options
        make_request
        handle_response
      end

      private

      def set_options
        @options = {
          language: language,
          user_secondary_language: user_secondary_language
        }.transform_keys! { |key| key.to_s.camelize(:lower) }
        @destination_url = "#{hotel_codes.join(',')}/details"
      end

      def make_request
        @response = get_request(@destination_url, options: @options)
      end

      def handle_response
        HotelBedsClient::HotelDetails::Models::Response.new(@response)
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
