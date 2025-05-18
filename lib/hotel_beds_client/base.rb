# frozen_string_literal: true

class HotelBedsClient::Base < BaseAction
  attr_reader :amadeus, :url

  BASE_URL = 'https://api.test.hotelbeds.com'

  def initialize
    super

    @url = [BASE_URL, api_type, api_version, request_url].join('/')
  end

  def api_version
    raise NotImplementedError
  end

  def api_type
    raise NotImplementedError
  end

  def request_url
    raise NotImplementedError
  end

  def headers
    {
      'Api-key' => RCreds.fetch(:hotelbeds, :hotels, :api_key),
      'X-Signature' => Digest::SHA256.hexdigest("#{RCreds.fetch(:hotelbeds, :hotels,
                                                                :api_key)}#{RCreds.fetch(:hotelbeds, :hotels,
                                                                                         :api_secret)}#{Time.current.to_i}")
    }
  end

  def get_request(destination_url = nil, options: {})
    request = Faraday.get([url, destination_url].compact.join('/'), options, headers)

    JSON.parse(request.body)
  end

  def post_request(destination_url = nil, options: {})
    request = Faraday.post([url, destination_url].compact.join('/'), options.deep_transform_keys! do |key|
      key.to_s.camelize(:lower)
    end.to_json, post_headers)

    JSON.parse(request.body)
  end

  def post_headers
    headers.merge!({ 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Accept-Encoding' => 'identity' })
  end
end
