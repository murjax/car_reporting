class QuantityReportRow
  attr_reader :car, :cars
  def initialize(car, cars)
    @car = car
    @cars = cars
  end

  def row
    [car.name, quantity]
  end

  private

  def quantity
    cars.select{ |item| item.name == car.name }.count
  end
end
