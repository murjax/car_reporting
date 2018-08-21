require 'csv'
require 'value_report'
require 'sales_report'
require 'quantity_report'
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
    SalesReport.new(cars).generate
  end

  def quantity_report
    QuantityReport.new(cars).generate
  end

  def quantity_report_headers
    ['Name', 'Quantity']
  end

  def quantity_report_row(row_car)
    quantity = cars.select{ |car| car.name == row_car.name }.count
    [row_car.name, quantity]
  end

  def unique_cars
    cars.uniq { |car| car.name }
  end
end
