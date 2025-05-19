# frozen_string_literal: true

require_relative 'hotel_beds_client/base'
require_relative 'hotel_beds_client/config'
require_relative 'hotel_beds_client/session'
require_relative 'hotel_beds_client/version'

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
  class Error < StandardError; end

  class << self
    attr_writer :config

    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end
  end
end
