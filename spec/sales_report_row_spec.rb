require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'
require_relative '../lib/sales_report_row.rb'

describe SalesReportRow do
  let(:car) { Car.new('Toyota', 'Camry', 2006, 17000, Date.new(2009,11,25)) }
  let(:sales_report_row) { SalesReportRow.new(car) }

  describe '#row' do
    it 'is name, sold, and sale date' do
      row = [car.name, 'Yes', car.sale_date]
      expect(sales_report_row.row).to eq(row)
    end
  end
end
