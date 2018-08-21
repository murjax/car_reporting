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

  describe '#row' do
    it 'is name, sold, and sale date' do
      row = [car_one.name, sales_report.csv_boolean(car_one.sold?), car_one.sale_date]
      expect(sales_report.row(car_one)).to eq(row)
    end
  end

  describe '#headers' do
    it 'is array of headers for sales report' do
      headers = ['Name', 'Sold', 'Sale Date']
      expect(sales_report.headers).to eq(headers)
    end
  end

  describe '#csv_boolean' do
    context 'true' do
      it "is 'Yes'" do
        expect(sales_report.csv_boolean(true)).to eq('Yes')
      end
    end

    context 'false' do
      it "is 'No'" do
        expect(sales_report.csv_boolean(false)).to eq('No')
      end
    end
  end
end
