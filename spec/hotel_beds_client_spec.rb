# frozen_string_literal: true

RSpec.describe HotelBedsClient do
  describe '.hotels_list' do
    subject(:res) { HotelBedsClient.hotels_list }

    before do
      request_stub = JSON.parse(File.read('spec/shared_context/stubs/hotels_list_stub.json'))

      allow_any_instance_of(HotelBedsClient::HotelsList::Main)
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

  describe '.hotel_details' do
    subject(:res) { HotelBedsClient.hotel_details(hotel_codes: [1]) }

    before do
      request_stub = JSON.parse(File.read('spec/shared_context/stubs/hotel_details_stub.json'))

      allow_any_instance_of(HotelBedsClient::HotelDetails::Main)
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
