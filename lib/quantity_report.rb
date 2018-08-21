require 'csv'
class QuantityReport
  attr_reader :cars
  def initialize(cars)
    @cars = cars
  end

  def generate
    csv = CSV.generate do |csv|
      csv << headers
      unique_cars.each do |car|
        csv << row(car)
      end
    end
  end

  def headers
    ['Name', 'Quantity']
  end

  def row(row_car)
    quantity = cars.select{ |car| car.name == row_car.name }.count
    [row_car.name, quantity]
  end

  def unique_cars
    cars.uniq { |car| car.name }
  end
end
