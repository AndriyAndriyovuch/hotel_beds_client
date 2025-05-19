# frozen_string_literal: true

require_relative '../base'

module HotelBedsClient
  module HotelContent
    class HotelDetails < Base
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
        options = {
          language: language,
          user_secondary_language: user_secondary_language
        }.transform_keys! { |key| key.to_s.camelize(:lower) }
        destination_url = "#{hotel_codes.join(',')}/details"

        get_request(destination_url, options: options)
      end

      private

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
