require 'csv'
require 'quantity_report_row'
class QuantityReport
  attr_reader :cars
  def initialize(cars)
    @cars = cars
  end

  def generate
    csv = CSV.generate do |csv|
      csv << headers
      unique_cars.each { |car| csv << QuantityReportRow.new(car, cars).row }
    end
  end

  private

  def headers
    ['Name', 'Quantity']
  end

  def unique_cars
    cars.uniq { |car| car.name }
  end
end
