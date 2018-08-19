require 'date'

class Car
  attr_reader :make, :model, :year, :price, :sale_date
  def initialize(make, model, year, price, sale_date)
    @make, @model, @year, @price, @sale_date = make, model, year, price, sale_date
  end

  def name
    "#{year} #{make} #{model}"
  end

  def sold?
    !sale_date.nil?
  end

  def depreciated_value
    price - (depreciate_per_year * age)
  end

  def age
    DateTime.now.year - year
  end

  private

  def depreciate_per_year
    price * 0.05
  end
end
