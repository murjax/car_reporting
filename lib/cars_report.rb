require 'csv'
class CarsReport
  attr_reader :cars, :type
  def initialize(cars, type)
    @cars, @type = cars, type
  end

  def generate
    if cars&.any? && type == :value
      value_report
    elsif cars&.any? && type == :quantity
      quantity_report
    elsif cars&.any? && type == :sales
      sales_report
    end
  end

  def value_report
    csv = CSV.generate do |csv|
      csv << value_report_headers
      cars.each do |car|
        csv << value_report_row(car)
      end
      csv << [total_value]
    end
  end

  def sales_report
    csv = CSV.generate do |csv|
      csv << sales_report_headers
      cars.each do |car|
        csv << sales_report_row(car)
      end
    end
  end

  def quantity_report
    csv = CSV.generate do |csv|
      csv << quantity_report_headers
      unique_cars.each do |car|
        csv << quantity_report_row(car)
      end
    end
  end

  def quantity_report_headers
    ['Name', 'Quantity']
  end

  def quantity_report_row(row_car)
    quantity = cars.select{ |car| car.name == row_car.name }.count
    [row_car.name, quantity]
  end

  def sales_report_headers
    ['Name', 'Sold', 'Sale Date']
  end

  def sales_report_row(car)
    [car.name, csv_boolean(car.sold?), car.sale_date]
  end

  def value_report_headers
    ['Name', 'Original Price', 'Depreciated Amount', 'Value Category']
  end

  def value_report_row(car)
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

  def csv_boolean(value)
    value ? 'Yes' : 'No'
  end

  def unique_cars
    cars.uniq { |car| car.name }
  end
end
