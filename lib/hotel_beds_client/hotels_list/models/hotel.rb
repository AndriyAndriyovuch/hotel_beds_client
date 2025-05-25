# frozen_string_literal: true

module HotelBedsClient
  module HotelContent
    module HotelsList
      class Hotel
        ALLOWED_KEYS = %w[code name description country_code state_code destination_code zone_code coordinates category_code
                          category_group_code chain_code accommodation_type_code board_codes segment_codes address
                          postal_code city email license giata_code phones rooms facilities terminals
                          interest_points images wildcards web last_update s2_c ranking].freeze

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
