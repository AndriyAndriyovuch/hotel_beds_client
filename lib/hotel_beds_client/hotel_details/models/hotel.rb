# frozen_string_literal: true

module HotelBedsClient
  module HotelDetails
    module Models
      class Hotel
        ALLOWED_KEYS = %w[s2_c accommodation_type address boards category category_group chain city code coordinates
                          country description destination email facilities giata_code images interest_points last_update
                          license name phones postal_code ranking rooms segments state terminals web wildcards zone].freeze

        attr_reader :json_data

        def initialize(data)
          @json_data = data

          data.each do |key, value|
            method_name = key.to_s.underscore

            next unless ALLOWED_KEYS.include?(method_name)

            define_singleton_method(method_name) { value }
          end
        end

        def available_keys
          ALLOWED_KEYS
        end
      end
    end
  end
end
