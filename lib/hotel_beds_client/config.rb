class HotelBedsClient::Config
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
