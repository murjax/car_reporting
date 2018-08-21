require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'
require_relative '../lib/cars_report.rb'

describe CarsReport do
  let(:car_one) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
  let(:car_two) { Car.new('Toyota', 'Camry', 2006, 17000, Date.new(2009,11,25)) }
  let(:cars_report) { CarsReport.new([car_one, car_two], :sales) }

  describe '#generate' do
    context 'no cars' do
      let(:cars_report) { CarsReport.new([], :sales) }
      it 'is nil' do
        expect(cars_report).not_to receive(:value_report)
        expect(cars_report).not_to receive(:sales_report)
        expect(cars_report).not_to receive(:quantity_report)
        expect(cars_report.generate).to be_nil
      end
    end

    context 'no type' do
      let(:cars_report) { CarsReport.new([car_one, car_two], nil) }
      it 'is nil' do
        expect(cars_report).not_to receive(:value_report)
        expect(cars_report).not_to receive(:sales_report)
        expect(cars_report).not_to receive(:quantity_report)
        expect(cars_report.generate).to be_nil
      end
    end

    context 'type is value' do
      let(:cars_report) { CarsReport.new([car_one, car_two], :value) }
      it 'calls value report' do
        expect(cars_report).to receive(:value_report)
        expect(cars_report).not_to receive(:sales_report)
        expect(cars_report).not_to receive(:quantity_report)
        cars_report.generate
      end
    end

    context 'type is sales' do
      let(:cars_report) { CarsReport.new([car_one, car_two], :sales) }
      it 'calls sales report' do
        expect(cars_report).not_to receive(:value_report)
        expect(cars_report).to receive(:sales_report)
        expect(cars_report).not_to receive(:quantity_report)
        cars_report.generate
      end
    end

    context 'type is quantity' do
      let(:cars_report) { CarsReport.new([car_one, car_two], :quantity) }
      it 'calls quantity report' do
        expect(cars_report).not_to receive(:value_report)
        expect(cars_report).not_to receive(:sales_report)
        expect(cars_report).to receive(:quantity_report)
        cars_report.generate
      end
    end
  end

  describe '#value_report' do
    it 'generates ValueReport' do
      expect_any_instance_of(ValueReport).to receive(:generate)
      cars_report.value_report
    end
  end

  describe '#sales_report' do
    it 'generates SalesReport' do
      expect_any_instance_of(SalesReport).to receive(:generate)
      cars_report.sales_report
    end
  end

  describe '#quantity_report' do
    let(:car_two) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    it 'generates quantity report csv' do
      expect(cars_report.quantity_report).to eq("Name,Quantity\n2004 Honda Civic,2\n")
    end
  end

  describe '#quantity_report_row' do
    let(:car_two) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    it 'is name and quantity' do
      row = [car_one.name, 2]
      expect(cars_report.quantity_report_row(car_one)).to eq(row)
    end
  end

  describe '#quantity_report_headers' do
    it 'is array of headers for quantity report' do
      headers = ['Name', 'Quantity']
      expect(cars_report.quantity_report_headers).to eq(headers)
    end
  end

  describe '#unique_cars' do
    let(:car_two) { Car.new('Honda', 'Civic', 2004, 14000, nil) }
    it 'is unique cars by name' do
      expect(cars_report.unique_cars.length).to eq(1)
    end
  end
end
