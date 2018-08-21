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
        expect_any_instance_of(ValueReport).not_to receive(:generate)
        expect_any_instance_of(SalesReport).not_to receive(:generate)
        expect_any_instance_of(QuantityReport).not_to receive(:generate)
        expect(cars_report.generate).to be_nil
      end
    end

    context 'no type' do
      let(:cars_report) { CarsReport.new([car_one, car_two], nil) }
      it 'is nil' do
        expect_any_instance_of(ValueReport).not_to receive(:generate)
        expect_any_instance_of(SalesReport).not_to receive(:generate)
        expect_any_instance_of(QuantityReport).not_to receive(:generate)
        expect(cars_report.generate).to be_nil
      end
    end

    context 'type is value' do
      let(:cars_report) { CarsReport.new([car_one, car_two], :value) }
      it 'calls value report' do
        expect_any_instance_of(ValueReport).to receive(:generate)
        expect_any_instance_of(SalesReport).not_to receive(:generate)
        expect_any_instance_of(QuantityReport).not_to receive(:generate)
        cars_report.generate
      end
    end

    context 'type is sales' do
      let(:cars_report) { CarsReport.new([car_one, car_two], :sales) }
      it 'calls sales report' do
        expect_any_instance_of(ValueReport).not_to receive(:generate)
        expect_any_instance_of(SalesReport).to receive(:generate)
        expect_any_instance_of(QuantityReport).not_to receive(:generate)
        cars_report.generate
      end
    end

    context 'type is quantity' do
      let(:cars_report) { CarsReport.new([car_one, car_two], :quantity) }
      it 'calls quantity report' do
        expect_any_instance_of(ValueReport).not_to receive(:generate)
        expect_any_instance_of(SalesReport).not_to receive(:generate)
        expect_any_instance_of(QuantityReport).to receive(:generate)
        cars_report.generate
      end
    end
  end
end
