class SalesReportRow
  attr_reader :car
  def initialize(car)
    @car = car
  end

  def row
    [car.name, sold_to_string, car.sale_date]
  end

  private

  def sold_to_string
    car.sold? ? 'Yes' : 'No'
  end
end
