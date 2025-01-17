require 'spec_helper'

RSpec.describe VehicleFactory do
  before(:each) do
    @factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end
  
  describe '#initialize' do
    it 'initialize' do
      expect(@factory).to be_an_instance_of(VehicleFactory)
    end
  end
  
  describe '#create_vehicle' do
    it 'creates vehicles with wa ev registration' do
      factory_result = @factory.create_vehicle(@wa_ev_registrations)
      expect(factory_result.count).to eq(1000)
      expect(factory_result.class).to eq(Array)
      expect(factory_result.first.class).to eq(Vehicle)
      expect(factory_result.first.engine).to eq(:ev)
    end
  end
  
  describe '#car_make' do
    it 'shows the most popuplar make' do
      factory_result = @factory.create_vehicle(@wa_ev_registrations)
      expect(@factory.car_make).to eq(["TESLA", 424])
    end
  end
  
  describe '#car_model' do
    it 'shows the most popular model' do
      factory_result = @factory.create_vehicle(@wa_ev_registrations)
      expect(@factory.car_model).to eq(["Leaf", 193])
    end
  end
end