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

  describe '#row' do
    let(:car_two) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    it 'is name and quantity' do
      row = [car_one.name, 2]
      expect(quantity_report.row(car_one)).to eq(row)
    end
  end

  describe '#quantity_report_headers' do
    it 'is array of headers for quantity report' do
      headers = ['Name', 'Quantity']
      expect(quantity_report.headers).to eq(headers)
    end
  end

  describe '#unique_cars' do
    let(:car_two) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    it 'is unique cars by name' do
      expect(quantity_report.unique_cars.length).to eq(1)
    end
  end
end
