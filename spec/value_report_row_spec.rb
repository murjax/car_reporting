require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'
require_relative '../lib/value_report_row.rb'

describe ValueReportRow do
  let(:car) { Car.new('Toyota', 'Camry', 2006, 17000, Date.new(2009,11,25)) }
  let(:value_report_row) { ValueReportRow.new(car) }

  describe '#row' do
    it 'is name, price, depreciated amount, and value category for car' do
      row = [car.name, car.price, value_report_row.lost_value, value_report_row.price_category]
      expect(value_report_row.row).to eq(row)
    end
  end

  describe '#lost_value' do
    it 'is car price minus car depreciated value' do
      lost_value = car.price - car.depreciated_value
      expect(value_report_row.lost_value).to eq(lost_value)
    end
  end

  describe '#price_category' do
    context 'less than 5000' do
      let(:car) { Car.new('Toyota', 'Camry', 2006, 2000, Date.new(2009,11,25)) }
      it 'is "Budget"' do
        expect(value_report_row.price_category).to eq('Budget')
      end
    end

    context 'less than 10000 and greater than or equal to 5000' do
      let(:car) { Car.new('Toyota', 'Camry', 2006, 7000, Date.new(2009,11,25)) }
      it 'is "Affordable"' do
        expect(value_report_row.price_category).to eq('Affordable')
      end
    end

    context 'less than 15000 and greater than or equal to 10000' do
      let(:car) { Car.new('Toyota', 'Camry', 2006, 13000, Date.new(2009,11,25)) }
      it "is 'Standard'" do
        expect(value_report_row.price_category).to eq('Standard')
      end
    end

    context 'less than 20000 and greater than or equal to 15000' do
      let(:car) { Car.new('Toyota', 'Camry', 2006, 16000, Date.new(2009,11,25)) }
      it "is 'Family'" do
        expect(value_report_row.price_category).to eq('Family')
      end
    end

    context 'greater than or equal to 20000' do
      let(:car) { Car.new('Toyota', 'Camry', 2006, 23000, Date.new(2009,11,25)) }
      it "is 'Luxury'" do
        expect(value_report_row.price_category).to eq('Luxury')
      end
    end
  end
end
