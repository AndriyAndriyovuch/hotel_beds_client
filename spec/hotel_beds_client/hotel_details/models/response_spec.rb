# frozen_string_literal: true

RSpec.describe HotelBedsClient::HotelDetails::Models::Response do
  describe '.hotels_list' do
    subject(:res) { described_class.new(data) }

    let(:data) { JSON.parse(File.read('spec/shared_context/stubs/hotel_details_stub.json')) }

    it 'returns correct keys' do
      expect(res.instance_variables).to contain_exactly(:@json, :@hotel_json, :@hotel)
    end

    it 'returns correct value types' do
      expect(res.json).to be_a(Hash)
      expect(res.hotel_json).to be_a(Hash)
      expect(res.hotel).to be_a(HotelBedsClient::HotelDetails::Models::Hotel)
    end
  end
end
