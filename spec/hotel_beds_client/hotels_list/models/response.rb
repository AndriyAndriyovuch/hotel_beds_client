# frozen_string_literal: true

RSpec.describe HotelBedsClient::HotelContent::HotelsList::Response do
  describe '.hotels_list' do
    subject(:res) { described_class.new(data) }

    let(:data) { JSON.parse(File.read('spec/shared_context/stubs/hotels_list_stub.json')) }

    it 'returns correct keys' do
      expect(res.instance_variables).to contain_exactly(:@json, :@from, :@to, :@total, :@hotels_json, :@hotels)
    end

    it 'returns correct value types' do
      expect(res.json).to be_a(Hash)

      expect(res.from).to be_a(Integer)
      expect(res.to).to be_a(Integer)
      expect(res.total).to be_a(Integer)

      expect(res.hotels_json).to be_a(Array)
      expect(res.hotels_json.sample).to be_a(Hash)

      expect(res.hotels).to be_a(Array)
      expect(res.hotels.sample).to be_a(HotelBedsClient::HotelContent::HotelsList::Hotel)
    end
  end
end
