class ValueReportRow
  attr_reader :car
  def initialize(car)
    @car = car
  end

  def row
    [car.name, car.price, lost_value, price_category]
  end

  def lost_value
    car.price - car.depreciated_value
  end

  def price_category
    budget_category || affordable_category || standard_category || family_category || luxury_category
  end

  private

  def budget_category
    'Budget' if car.price < 5000
  end

  def affordable_category
    'Affordable' if car.price < 10000 && car.price >= 5000
  end

  def standard_category
    'Standard' if car.price < 15000 && car.price >= 10000
  end

  def family_category
    'Family' if car.price < 20000 && car.price >= 15000
  end

  def luxury_category
    'Luxury' if car.price >= 20000
  end
end
