# frozen_string_literal: true

require_relative 'hotel'

module HotelBedsClient
  module HotelContent
    module HotelsList
      class Response
        attr_accessor :json, :from, :to, :total, :hotels, :hotels_json

        def initialize(attrs = {})
          @json = attrs
          @from = attrs['from']
          @to = attrs['to']
          @total = attrs['total']
          @hotels_json = attrs['hotels']
          @hotels = parse_hotels
        end

        private

        def parse_hotels
          @hotels_json.map { |hotel| HotelBedsClient::HotelContent::HotelsList::Hotel.new(hotel) }
        end
      end
    end
  end
end
