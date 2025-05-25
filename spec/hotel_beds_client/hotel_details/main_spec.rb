# frozen_string_literal: true

RSpec.describe HotelBedsClient::HotelDetails::Main do
  describe '.hotel_details' do
    subject(:res) { described_class.call(hotel_codes: [1], language: nil, user_secondary_language: nil) }

    before do
      request_stub = JSON.parse(File.read('spec/shared_context/stubs/hotel_details_stub.json'))

      allow_any_instance_of(described_class)
        .to receive(:get_request)
        .with('1/details', kind_of(Hash))
        .and_return(request_stub)
    end

    it 'returns correct class' do
      expect(res).to be_a(HotelBedsClient::HotelDetails::Models::Response)
    end

    it 'returns correct keys' do
      expect(res.instance_variables).to contain_exactly(:@json, :@hotels_json, :@hotels)
    end

    it 'returns correct value types' do
      expect(res.json).to be_a(Hash)
      expect(res.hotels_json).to be_a(Array)

      expect(res.hotels).to be_a(Array)
      expect(res.hotels.first).to be_a(HotelBedsClient::HotelDetails::Models::Hotel)
    end
  end
end
