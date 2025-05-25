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
require_relative 'hotel_beds_client/hotels_list/main'
require_relative 'hotel_beds_client/hotel_details/main'

require 'json'
require 'digest'
require 'active_support/inflector'

module HotelBedsClient
  class << self
    attr_writer :config

    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end

    def hotels_list(destination_code: nil, country_code: nil, codes: [], include_hotels: nil, fields: 'all', language: nil,
                    from: nil, to: nil, use_secondary_language: false, last_update_time: nil, pms_room_code: false)
      HotelBedsClient::HotelsList::Main.call(destination_code: destination_code, country_code: country_code,
                                             codes: codes, include_hotels: include_hotels, fields: fields,
                                             language: language, from: from, to: to,
                                             use_secondary_language: use_secondary_language,
                                             last_update_time: last_update_time, pms_room_code: pms_room_code)
    end

    def hotel_details(hotel_codes:, language: nil, user_secondary_language: nil)
      HotelBedsClient::HotelDetails::Main.call(hotel_codes: hotel_codes,
                                               language: language,
                                               user_secondary_language: user_secondary_language)
    end

    # def booking_availability(stay:, occupancies:, geolocation: {}, filter: {}, boards: {}, rooms: {},
    #                          daily_rate: false, source_market: nil, aif_use: false, platform: nil,
    #                          language: nil, keywords: {}, hotels: {}, review: [],
    #                          accommodations: [], inclusions: [])
    #   HotelBedsClient::Booking::Availability.call(stay: stay, geolocation: geolocation, filter: filter, boards: boards,
    #                                               rooms: rooms, daily_rate: daily_rate, source_market: source_market,
    #                                               aif_use: aif_use, platform: platform, language: language,
    #                                               occupancies: occupancies, keywords: keywords, hotels: hotels,
    #                                               review: review, accommodations: accommodations, inclusions: inclusions)
    # end

    # def check_rate(rooms:, upselling: false, expand_c_x_l: false, language: nil)
    #   HotelBedsClient::Booking::CheckRate.call(upselling: upselling, expand_c_x_l: expand_c_x_l,
    #                                            language: language, rooms: rooms)
    # end

    # def confirmation(holder: {}, payment_data: {}, client_reference: nil, creation_user: nil, remark: nil, voucher: {},
    #                  tolerance: nil, language: nil, rooms: [])
    #   HotelBedsClient::Booking::Confirmation.call(holder: holder, payment_data: payment_data,
    #                                               client_reference: client_reference, creation_user: creation_user,
    #                                               remark: remark, voucher: voucher, tolerance: tolerance,
    #                                               language: language, rooms: rooms)
    # end

    # def destinations(language:, country_code:)
    #   HotelBedsClient::Destinations::Main.call(language: language, country_code: country_code)
    # end
  end
end
