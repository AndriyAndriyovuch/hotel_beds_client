# frozen_string_literal: true

class HotelBedsClient::Config
  attr_writer :base_url, :api_key, :api_secret

  def base_url
    @base_url ||= 'https://api.test.hotelbeds.com'
  end

  def api_key
    @api_key ||= nil
  end

  def api_secret
    @api_secret ||= nil
  end
end
