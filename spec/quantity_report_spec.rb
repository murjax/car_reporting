require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'
require_relative '../lib/quantity_report.rb'

describe QuantityReport do
  let(:car_one) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
  let(:car_two) { Car.new('Toyota', 'Camry', 2006, 17000, Date.new(2009,11,25)) }
  let(:quantity_report) { QuantityReport.new([car_one, car_two]) }

  describe '#generate' do
    let(:car_two) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    it 'generates quantity report csv' do
      expect(quantity_report.generate).to eq("Name,Quantity\n2004 Honda Civic,2\n")
    end
  end
end
