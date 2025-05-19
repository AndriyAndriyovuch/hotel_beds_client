# frozen_string_literal: true

require_relative 'hotel_beds_client/base'
require_relative 'hotel_beds_client/config'
require_relative 'hotel_beds_client/session'
require_relative 'hotel_beds_client/version'
require_relative 'hotel_beds_client/errors'

# Booking
require_relative 'hotel_beds_client/booking/availability'
require_relative 'hotel_beds_client/booking/check_rate'
require_relative 'hotel_beds_client/booking/confirmation'

# Destinations
require_relative 'hotel_beds_client/destinations/main'

# HotelContent
require_relative 'hotel_beds_client/hotel_content/hotels'
require_relative 'hotel_beds_client/hotel_content/hotel_details'

require 'json'
require 'digest'

module HotelBedsClient
  class << self
    attr_writer :config

    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end

    def hotels(
      destination_code: nil, country_code: nil, codes: [], include_hotels: nil, fields: [],
      language: nil, from: nil, to: nil, use_secondary_language: false, last_update_time: nil, pms_room_code: false
    )
      HotelBedsClient::HotelContent::Hotels.call(
        destination_code: destination_code, country_code: country_code, codes: codes, include_hotels: include_hotels,
        fields: fields, language: language, from: from, to: to, use_secondary_language: use_secondary_language,
        last_update_time: last_update_time, pms_room_code: pms_room_code
      )
    end

    def hotel_details(hotel_codes:, language:, user_secondary_language:)
      HotelBedsClient::HotelContent::HotelDetails.call(hotel_codes: hotel_codes,
                                                       language: language,
                                                       user_secondary_language: user_secondary_language)
    end
  end
end
