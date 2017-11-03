require 'csv'
require_relative '../models/customer.rb'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    @customers = []
    load_csv
  end

  def add(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def all
    @customers
  end

  def find(customer_id)
    @customers.find { |customer| customer.id == customer_id }
  end

  def delete(customer)
    @customers.delete(customer)
    save_csv
  end

  private

  def load_csv
    File.open(@csv_file_path, 'w').close unless File.exist? @csv_file_path

    CSV.foreach(@csv_file_path, @csv_options) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb', @csv_options) do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
