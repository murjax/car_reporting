require 'spec_helper'
require_relative '../lib/car.rb'
require_relative '../lib/quantity_report_row.rb'

describe QuantityReportRow do
  describe '#row' do
    let(:car) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    let(:cars) { [car] }
    let(:quantity_report_row) { QuantityReportRow.new(car, cars) }

    it 'is array of car name and quantity' do
      expect(quantity_report_row.row).to eq([car.name, 1])
    end
  end
end
