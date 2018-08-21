require 'csv'
require 'value_report'
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
    ValueReport.new(cars).generate
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

  def csv_boolean(value)
    value ? 'Yes' : 'No'
  end

  def unique_cars
    cars.uniq { |car| car.name }
  end
end
