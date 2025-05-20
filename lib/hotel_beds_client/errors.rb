# frozen_string_literal: true

module HotelBedsClient
  class IncorrectDateFormatError < StandardError
    DEFAULT_MESSAGE = 'Incorrect date format, required format is YYYY-MM-DD (String), Date, Time or DateTime.'

    def message
      DEFAULT_MESSAGE
    end
  end
end
