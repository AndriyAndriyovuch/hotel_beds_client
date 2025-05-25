# frozen_string_literal: true

RSpec.describe HotelBedsClient::HotelDetails::Models::Hotel do
  describe '.hotels_list' do
    subject(:res) { described_class.new(data) }

    let(:data) { JSON.parse(File.read('spec/shared_context/stubs/hotel_details_stub.json'))['hotel'] }

    it 'returns correct class' do
      expect(res).to be_a(described_class)
    end

    it 'returns correct keys' do
      expect(res.instance_variables).to contain_exactly(:@json_data)
    end

    it 'returns correct hotel data values' do
      expect(res.code).to eq 1

      expect(res.name).to include('content' => 'Ohtels Villa Dorada')

      expect(res.description['content']).to start_with('This hotel is located about 150 metres')

      expect(res.country).to include(
        'code' => 'ES',
        'isoCode' => 'ES',
        'description' => { 'content' => 'Spain' }
      )

      expect(res.state).to include(
        'code' => '43',
        'name' => 'TARRAGONA'
      )

      expect(res.destination).to include(
        'code' => 'SAL',
        'name' => { 'content' => 'Salou Area / Costa Dorada' },
        'countryCode' => 'ES'
      )

      expect(res.zone).to include(
        'zoneCode' => 10,
        'name' => 'Salou',
        'description' => { 'content' => 'Salou' }
      )

      expect(res.coordinates).to eq(
        'longitude' => 1.152529,
        'latitude' => 41.068407
      )

      expect(res.category).to include(
        'code' => '3EST',
        'description' => { 'content' => '3 STARS' }
      )

      expect(res.category_group).to include(
        'code' => 'GRUPO3',
        'description' => { 'content' => 'Includes 3-star hotels and rural hotels.' }
      )

      expect(res.chain).to include(
        'code' => 'OHTEL',
        'description' => { 'content' => 'OHTELS' }
      )

      expect(res.accommodation_type).to include(
        'code' => 'H',
        'typeDescription' => 'Hotel',
        'typeMultiDescription' => { 'content' => 'Hotel' }
      )

      expect(res.boards.map { |b| b['code'] }).to match_array(%w[BB HB RO FB AI])
      expect(res.segments.map { |s| s['code'] }).to match_array([81, 37])

      expect(res.address).to include(
        'content' => 'Carrer Del Vendrell, 11',
        'street' => 'Carrer Del Vendrell',
        'number' => '11'
      )

      expect(res.postal_code).to eq '43840'
      expect(res.city).to eq('content' => 'SALOU')
      expect(res.email).to eq 'comercial@ohtels.es'
      expect(res.license).to eq 'HT-000473'
      expect(res.giata_code).to eq 35_142

      expect(res.phones).to all(include('phoneNumber', 'phoneType'))
      expect(res.rooms).to all(include('roomCode', 'minPax'))
      expect(res.facilities).to all(include('facilityCode', 'facilityGroupCode'))

      expect(res.terminals.map { |t| t['terminalCode'] }).to include('BCN', 'REU')
      expect(res.interest_points.map { |p| p['poiName'] }).to include('Barcelona', 'reus')

      expect(res.images).to all(include('path', 'type'))

      expect(res.web).to be_a(String)
      expect(res.wildcards).to be_a(Array)
      expect(res.wildcards.first).to be_a(Hash)
    end
  end
end
