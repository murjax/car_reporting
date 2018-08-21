require 'value_report'
require 'sales_report'
require 'quantity_report'
class CarsReport
  attr_reader :cars, :type
  def initialize(cars, type)
    @cars, @type = cars, type
  end

  def generate
    return unless cars&.any? && type
    value_report || quantity_report || sales_report
  end

  private

  def value_report
    ValueReport.new(cars).generate if type == :value
  end

  def sales_report
    SalesReport.new(cars).generate if type == :sales
  end

  def quantity_report
    QuantityReport.new(cars).generate if type == :quantity
  end
end
