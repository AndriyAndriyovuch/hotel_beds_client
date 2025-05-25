# frozen_string_literal: true

require_relative 'hotel'

module HotelBedsClient
  module HotelDetails
    module Models
      class Response
        attr_accessor :json, :hotel, :hotel_json

        def initialize(attrs = {})
          @json = attrs

          @hotel_json = attrs['hotel']
          @hotel = HotelBedsClient::HotelDetails::Models::Hotel.new(hotel_json)
        end
      end
    end
  end
end
