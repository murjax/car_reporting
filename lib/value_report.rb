require 'csv'
require 'value_report_row'
class ValueReport
  attr_reader :cars
  def initialize(cars)
    @cars = cars
  end

  def generate
    csv = CSV.generate do |csv|
      csv << headers
      cars.each { |car| csv << ValueReportRow.new(car).row }
      csv << [total_value]
    end
  end

  def total_value
    cars.inject(0) { |sum, car| sum + car.price }
  end

  private

  def headers
    ['Name', 'Original Price', 'Depreciated Amount', 'Value Category']
  end
end
