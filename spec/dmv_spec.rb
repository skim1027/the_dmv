require 'spec_helper'

RSpec.describe Dmv do
  before(:each) do
    @dmv = Dmv.new
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @facility_3 = Facility.new({name: 'DMV Northwest Branch', address: '3698 W. 44th Avenue Denver CO 80211', phone: '(720) 865-4600'})
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
    @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations

  end
  
  describe '#initialize' do
    it 'can initialize' do
      expect(@dmv).to be_an_instance_of(Dmv)
      expect(@dmv.facilities).to eq([])
    end
  end
  
  describe '#add facilities' do
    it 'can add available facilities' do
      expect(@dmv.facilities).to eq([])
      @dmv.add_facility(@facility_1)
      expect(@dmv.facilities).to eq([@facility_1])
    end
  end
  
  describe '#facilities_offering_service' do
    it 'can return list of facilities offering a specified Service' do
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_2.add_service('New Drivers License')
      @facility_2.add_service('Road Test')
      @facility_2.add_service('Written Test')
      @facility_3.add_service('New Drivers License')
      @facility_3.add_service('Road Test')
      
      @dmv.add_facility(@facility_1)
      @dmv.add_facility(@facility_2)
      @dmv.add_facility(@facility_3)
      
      expect(@dmv.facilities_offering_service('Road Test')).to eq([@facility_2, @facility_3])
    end
  end
  
  describe '#create_facility_helper' do
    it 'converts co facility information from API correct format' do
      co_facility_info = @dmv.create_facility_helper(@co_dmv_office_locations)
      expect(co_facility_info.class).to eq(Array)
      expect(co_facility_info.first).to eq({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    end
    
    it 'converts ny facility information from API correct format' do
      ny_facility_info = @dmv.create_facility_helper(@ny_dmv_office_locations)
      expect(ny_facility_info.class).to eq(Array)
      expect(ny_facility_info.first).to eq({name: 'EVANS COUNTY OFFICE', address: '6853 ERIE RD DERBY NY 14006', phone: '(716) 858-7450'})
    end

    it 'converts MO facility information from API correct format' do
      mo_facility_info = @dmv.create_facility_helper(@mo_dmv_office_locations)
      expect(mo_facility_info.class).to eq(Array)
      expect(mo_facility_info.first).to eq({name: 'OAKVILLE', address: '3164 TELEGRAPH ROAD ST LOUIS MO 63125', phone: '(314) 887-1050'})
    end
  end

  describe '#create_facility' do
    it 'converts co facility information from API' do
      @dmv.create_facility_helper(@co_dmv_office_locations)
      expect(@dmv.create_facility.count).to eq(5)
      expect(@dmv.create_facility.class).to eq(Array)
      expect(@dmv.create_facility.first.class).to eq(Facility)
      expect(@dmv.create_facility.first.name).to eq('DMV Tremont Branch')
      expect(@dmv.create_facility.first.phone).to eq('(720) 865-4600')
      expect(@dmv.create_facility.first.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
    end

    it 'converts ny facility information from API' do
      @dmv.create_facility_helper(@ny_dmv_office_locations)
      expect(@dmv.create_facility.count).to eq(172)
      expect(@dmv.create_facility.class).to eq(Array)
      expect(@dmv.create_facility.first.class).to eq(Facility)
      expect(@dmv.create_facility.first.name).to eq('EVANS COUNTY OFFICE')
      expect(@dmv.create_facility.first.phone).to eq('(716) 858-7450')
      expect(@dmv.create_facility.first.address).to eq('6853 ERIE RD DERBY NY 14006')
    end
    
    it 'converts mo facility information from API' do
      @dmv.create_facility_helper(@mo_dmv_office_locations)
      expect(@dmv.create_facility.count).to eq(178)
      expect(@dmv.create_facility.class).to eq(Array)
      expect(@dmv.create_facility.first.class).to eq(Facility)
      expect(@dmv.create_facility.first.name).to eq('OAKVILLE')
      expect(@dmv.create_facility.first.phone).to eq('(314) 887-1050')
      expect(@dmv.create_facility.first.address).to eq('3164 TELEGRAPH ROAD ST LOUIS MO 63125')
    end
  end
  
  
end
