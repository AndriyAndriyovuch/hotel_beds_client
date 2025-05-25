# frozen_string_literal: true

module HotelBedsClient
  class Base
    attr_reader :url

    def initialize(args = {})
      raise NonKeywordArgumentsError unless args.is_a?(Hash)

      @url = [HotelBedsClient.config.base_url, api_type, api_version, request_url].join('/')

      @args = @data = args
      @args.each do |name, value|
        self.class.attr_reader(name) unless respond_to?(name)
        instance_variable_set("@#{name}", value)
      end
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

    def self.call(*args, &block)
      new(*args, &block).call
    end

    def headers
      {
        'Api-key' => HotelBedsClient.config.api_key,
        'X-Signature' => x_signature
      }
    end

    def get_request(destination_url = nil, options: {})
      options.deep_transform_keys! { |key| key.to_s.camelize(:lower) }.compact!
      # options = options.to_json if options.present?

      request = Faraday.get([url, destination_url].compact.join('/'), options, headers)

      JSON.parse(request.body)
    end

    def post_request(destination_url = nil, options: {})
      options.deep_transform_keys! { |key| key.to_s.camelize(:lower) }.compact!
      # options = options.to_json if options.present?

      request = Faraday.post([url, destination_url].compact.join('/'), options, post_headers)

      JSON.parse(request.body)
    end

    def post_headers
      headers.merge!({ 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Accept-Encoding' => 'identity' })
    end

    def x_signature
      Digest::SHA256.hexdigest("#{HotelBedsClient.config.api_key}#{HotelBedsClient.config.api_secret}#{Time.current.to_i}")
    end

    def to_safe_date(date)
      return if date.nil?

      if date.is_a?(String)
        raise IncorrectDateFormatError unless date.match?(/\d{4}-\d{2}-\d{2}/)

        date
      else
        begin
          date.strftime('%Y-%m-%d')
        rescue StandardError
          raise IncorrectDateFormatError
        end
      end
    end
  end
end
