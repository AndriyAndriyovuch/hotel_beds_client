# frozen_string_literal: true

RSpec.describe HotelBedsClient::HotelsList::Main do
  describe '.hotels_list' do
    subject(:res) do
      described_class.call(destination_code: nil, country_code: nil, codes: [], include_hotels: nil, fields: 'all', language: nil,
                           from: nil, to: nil, use_secondary_language: false, last_update_time: nil, pms_room_code: false)
    end

    before do
      request_stub = JSON.parse(File.read('spec/shared_context/stubs/hotels_list_stub.json'))

      allow_any_instance_of(described_class)
        .to receive(:get_request)
        .with(kind_of(Hash))
        .and_return(request_stub)
    end

    it 'returns correct class' do
      expect(res).to be_a(HotelBedsClient::HotelsList::Models::Response)
    end

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
      expect(res.hotels.sample).to be_a(HotelBedsClient::HotelsList::Models::Hotel)
    end
  end
end
