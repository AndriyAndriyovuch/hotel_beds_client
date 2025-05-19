# frozen_string_literal: true

module HotelBedsClient
  class Base
    attr_reader :url

    def initialize
      super

      @url = [HotelBedsClient.config.base_url, api_type, api_version, request_url].join('/')
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
        'Api-key' => HotelBedsClient.config.api_key,
        'X-Signature' => x_signature
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

    def x_signature
      Digest::SHA256.hexdigest("#{HotelBedsClient.config.api_key}#{HotelBedsClient.config.api_secret}#{Time.current.to_i}")
    end
  end
end
