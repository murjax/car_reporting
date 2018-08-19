require 'spec_helper'
require 'date'
require_relative '../lib/car.rb'

describe Car do
  let(:car) { Car.new('Chevrolet', 'S10', 1999, 20000, Date.new(1998,11,25)) }
  describe '#name' do
    it 'concats make, model, and year' do
      expect(car.name).to eq("#{car.year} #{car.make} #{car.model}")
    end
  end

  describe '#sold?' do
    context 'sale date present' do
      it 'is true' do
        expect(car.sold?).to eq(true)
      end
    end

    context 'sale date not present' do
      let(:car) { Car.new('Chevrolet', 'S10', 1999, 20000, nil) }
      it 'is false' do
        expect(car.sold?).to eq(false)
      end
    end
  end

  describe '#depreciated_value' do
    it 'is price minus 5% for each year of age.' do
      age = car.age
      five_percent = car.price * 0.05
      depreciated_value = car.price - (five_percent * age)
      expect(car.depreciated_value).to eq(depreciated_value)
    end
  end

  describe '#age' do
    it 'is age from manufacture year' do
      age = DateTime.now.year - car.year
      expect(car.age).to eq(age)
    end
  end
end
