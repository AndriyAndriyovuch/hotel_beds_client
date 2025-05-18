# frozen_string_literal: true

require_relative 'hotel_beds_client/version'
require_relative 'hotel_beds_client/config'
require 'json'
require 'digest'

module HotelBedsClient
  class Error < StandardError; end

  module_function

  def config
    @config ||= Config.new
  end

  def configure
    yield(config)
  end
end
