require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'
require_relative '../lib/sales_report.rb'

describe SalesReport do
  let(:car_one) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
  let(:car_two) { Car.new('Toyota', 'Camry', 2006, 17000, Date.new(2009,11,25)) }
  let(:sales_report) { SalesReport.new([car_one, car_two]) }

  describe '#generate' do
    it 'generates sales report csv' do
      expect(sales_report.generate).to eq("Name,Sold,Sale Date\n2004 Honda Civic,No,\n2006 Toyota Camry,Yes,2009-11-25\n")
    end
  end
end
