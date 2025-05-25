# frozen_string_literal: true

RSpec.describe HotelBedsClient::HotelsList::Models::Hotel do
  describe '.hotels_list' do
    subject(:res) { described_class.new(data) }

    let(:data) { JSON.parse(File.read('spec/shared_context/stubs/hotels_list_stub.json'))['hotels'].first }

    it 'returns correct class' do
      expect(res).to be_a(described_class)
    end

    it 'returns correct keys' do
      expect(res.instance_variables).to contain_exactly(:@json_data)
    end

    it 'returns correct value types' do
      expect(res.code).to eq 1

      expect(res.name).to be_a(Hash)
      expect(res.name['content']).to eq 'Ohtels Villa Dorada'

      expect(res.description).to be_a(Hash)
      expect(res.description['content']).to start_with('This hotel is located about 150 metres')

      expect(res.country_code).to eq 'ES'
      expect(res.state_code).to eq '43'
      expect(res.destination_code).to eq 'SAL'
      expect(res.zone_code).to eq 10

      expect(res.coordinates).to be_a(Hash)
      expect(res.coordinates['longitude']).to eq 1.152529
      expect(res.coordinates['latitude']).to eq 41.068407

      expect(res.category_code).to eq '3EST'
      expect(res.category_group_code).to eq 'GRUPO3'
      expect(res.chain_code).to eq 'OHTEL'
      expect(res.accommodation_type_code).to eq 'H'

      expect(res.board_codes).to match_array(%w[BB AI HB FB RO])
      expect(res.segment_codes).to match_array([81, 37])

      expect(res.address).to include(
        'content' => 'Carrer Del Vendrell, 11',
        'street' => 'Carrer Del Vendrell',
        'number' => '11'
      )

      expect(res.postal_code).to eq '43840'
      expect(res.city).to eq({ 'content' => 'SALOU' })
      expect(res.email).to eq 'comercial@ohtels.es'
      expect(res.license).to eq 'HT-000473'
      expect(res.giata_code).to eq 35_142

      expect(res.phones).to all(include('phoneNumber', 'phoneType'))
      expect(res.rooms).to all(include('roomCode', 'minPax', 'roomFacilities'))
      expect(res.facilities).to all(include('facilityCode', 'facilityGroupCode'))

      expect(res.terminals.map { |t| t['terminalCode'] }).to include('BCN', 'REU')
      expect(res.interest_points.map { |p| p['poiName'] }).to include('Barcelona', 'reus')

      expect(res.images).to all(include('path', 'imageTypeCode'))

      expect(res.wildcards).to all(include('roomCode', 'characteristicCode', 'hotelRoomDescription'))
      expect(res.web).to eq 'http://www.ohtels.es/'
      expect(res.last_update).to eq '2025-03-16'
      expect(res.s2_c).to eq '4*'
      expect(res.ranking).to eq 39
    end
  end
end
