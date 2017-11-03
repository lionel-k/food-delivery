require 'csv'
require_relative '../models/order'
require_relative 'meal_repository'
require_relative 'customer_repository'
require_relative 'employee_repository'
require 'pry-byebug'

class OrderRepository
  def initialize(csv_file_path, meal_repository, employee_repository, customer_repository)
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @orders = []
    load_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def add(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def find(order_id)
    @orders.find { |order| order.id == order_id }
  end

  def mark_as_deliver(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    File.open(@csv_file_path, 'w').close unless File.exist? @csv_file_path

    CSV.foreach(@csv_file_path, @csv_options) do |row|
      attributes = build_attributes(row)
      @orders << Order.new(attributes)
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb', @csv_options) do |csv|
      csv << ["id", "delivered", "meal_id", "employee_id", "customer_id"]
      @orders.each do |order|
        customer_id = order.customer.id
        meal_id = order.meal.id
        employee_id = order.employee.id
        csv << [order.id, order.delivered?, meal_id, employee_id, customer_id]
      end
    end
  end

  def build_attributes(csv_row)
    attributes = {}
    attributes[:id] = csv_row[:id].to_i
    attributes[:customer] = @customer_repository.find(csv_row[:customer_id].to_i)
    attributes[:meal] = @meal_repository.find(csv_row[:meal_id].to_i)
    attributes[:employee] = @employee_repository.find(csv_row[:employee_id].to_i)
    attributes[:delivered] = csv_row[:delivered] == "true"
    attributes
  end
end


# meal_repository = MealRepository.new("data/meals.csv")
# customer_repository = CustomerRepository.new("data/customers.csv")
# employee_repository = EmployeeRepository.new("data/employees.csv")
# csv_file_path = "data/orders.csv"
# order_repo = OrderRepository.new(csv_file_path, meal_repository, customer_repository, employee_repository)

# p order_repo.orders[2].employee

# order = order_repo.undelivered_orders.first
# # p order.customer.id.class
# # p order.employee.class
# order_repo.add(order)
# p order_repo.orders

