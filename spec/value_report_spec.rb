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

  describe '#headers' do
    it 'is array of headers for value report' do
      headers = ['Name', 'Original Price', 'Depreciated Amount', 'Value Category']
      expect(value_report.headers).to eq(headers)
    end
  end

  describe '#row' do
    it 'is name, price, depreciated amount, and value category for car' do
      row = [car_one.name, car_one.price, value_report.lost_value(car_one), value_report.price_category(car_one.price)]
      expect(value_report.row(car_one)).to eq(row)
    end
  end

  describe '#lost_value' do
    it 'is car price minus car depreciated value' do
      lost_value = car_one.price - car_one.depreciated_value
      expect(value_report.lost_value(car_one)).to eq(lost_value)
    end
  end

  describe '#price_category' do
    context 'less than 5000' do
      it 'is "Budget"' do
        expect(value_report.price_category(2000)).to eq('Budget')
      end
    end

    context 'less than 10000 and greater than or equal to 5000' do
      it 'is "Affordable"' do
        expect(value_report.price_category(7000)).to eq('Affordable')
      end
    end

    context 'less than 15000 and greater than or equal to 10000' do
      it "is 'Standard'" do
        expect(value_report.price_category(13000)).to eq('Standard')
      end
    end

    context 'less than 20000 and greater than or equal to 15000' do
      it "is 'Family'" do
        expect(value_report.price_category(16000)).to eq('Family')
      end
    end

    context 'greater than or equal to 20000' do
      it "is 'Luxury'" do
        expect(value_report.price_category(23000)).to eq('Luxury')
      end
    end
  end

  describe '#total_value' do
    it 'is sum of car prices' do
      expected_sum = car_one.price + car_two.price
      expect(value_report.total_value).to eq(expected_sum)
    end
  end
end
