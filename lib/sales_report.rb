require 'csv'
class SalesReport
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
    end
  end

  def headers
    ['Name', 'Sold', 'Sale Date']
  end

  def row(car)
    [car.name, csv_boolean(car.sold?), car.sale_date]
  end

  def csv_boolean(value)
    value ? 'Yes' : 'No'
  end
end
