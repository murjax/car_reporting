require 'csv'
require 'sales_report_row'
class SalesReport
  attr_reader :cars
  def initialize(cars)
    @cars = cars
  end

  def generate
    csv = CSV.generate do |csv|
      csv << headers
      cars.each { |car| csv << SalesReportRow.new(car).row }
    end
  end

  private

  def headers
    ['Name', 'Sold', 'Sale Date']
  end
end
