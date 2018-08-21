require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'
require_relative '../lib/value_report.rb'

describe ValueReport do
  let(:car_one) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
  let(:car_two) { Car.new('Toyota', 'Camry', 2006, 17000, Date.new(2009,11,25)) }
  let(:value_report) { ValueReport.new([car_one, car_two]) }

  describe '#generate' do
    it 'generates value report csv' do
      report = "Name,Original Price,Depreciated Amount,Value Category\n2004 Honda Civic,14000,9800.0,Standard\n2006 Toyota Camry,17000,10200.0,Family\n31000\n"
      expect(value_report.generate).to eq(report)
    end
  end

  describe '#total_value' do
    it 'is sum of car prices' do
      expected_sum = car_one.price + car_two.price
      expect(value_report.total_value).to eq(expected_sum)
    end
  end
end
