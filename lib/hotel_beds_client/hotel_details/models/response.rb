# frozen_string_literal: true

require_relative 'hotel'

module HotelBedsClient
  module HotelDetails
    module Models
      class Response
        attr_accessor :json, :hotels, :hotels_json

        def initialize(attrs = {})
          @json = attrs

          @hotels_json = attrs['hotel'].nil? ? attrs['hotels'] : [attrs['hotel']] # can be single if there is only one hotel
          @hotels = @hotels_json.map { |h| HotelBedsClient::HotelDetails::Models::Hotel.new(h) } unless hotels_json.nil?
        end
      end
    end
  end
end
