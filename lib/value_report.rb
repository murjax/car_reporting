require 'csv'
class ValueReport
  attr_reader :cars
  def initialize(cars)
    @cars = cars
  end

  def generate
    csv = CSV.generate do |csv|
      csv << headers
      cars.each do |car|
        csv << row(car)
      end
      csv << [total_value]
    end
  end

  def headers
    ['Name', 'Original Price', 'Depreciated Amount', 'Value Category']
  end

  def row(car)
    [car.name, car.price, lost_value(car), price_category(car.price)]
  end

  def lost_value(car)
    car.price - car.depreciated_value
  end

  def price_category(value)
    if value < 5000
      'Budget'
    elsif value < 10000 && value >= 5000
      'Affordable'
    elsif value < 15000 && value >= 10000
      'Standard'
    elsif value < 20000 && value >= 15000
      'Family'
    else
      'Luxury'
    end
  end

  def total_value
    cars.inject(0) { |sum, car| sum + car.price }
  end
end
