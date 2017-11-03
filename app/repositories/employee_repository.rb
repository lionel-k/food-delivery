require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    @employees = []
    load_csv
  end

  def all_delivery_guys
    @employees.select { |employee| employee.delivery_guy? }
  end

  def find(employee_id)
    @employees.find { |employee| employee.id == employee_id }
  end

  def find_by_username(employee_username)
    @employees.find { |employee| employee.username == employee_username }
  end

  private

  def load_csv
    File.open(@csv_file_path, 'w').close unless File.exist? @csv_file_path

    CSV.foreach(@csv_file_path, @csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end

