require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_view = OrderView.new
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @order_view.display_orders(undelivered_orders)
  end

  def add
    meal = build_meal
    customer = build_customer
    employee = build_employee

    order = Order.new(customer: customer, meal: meal, employee: employee)
    @order_repository.add(order)
  end

  def list_my_orders(employee)
    undelivered_orders = @order_repository.undelivered_orders
    employee_orders = undelivered_orders.select do |order|
      order.employee.id == employee.id
    end
    @order_view.display_orders(employee_orders)
    employee_orders
  end

  def mark_as_delivered(employee)
    employee_orders = list_my_orders(employee)
    order_id = @order_view.ask_for("Order ID")
    order = @order_repository.find(order_id)
    if order && (employee_orders.include? order)
      @order_repository.mark_as_deliver(order)
    else
      @order_view.wrong_order_id
    end
  end

  private

  def build_meal
    @order_view.display_meals(@meal_repository.all)
    meal_id = @order_view.ask_for("Meal ID")
    @meal_repository.find(meal_id)
  end

  def build_customer
    @order_view.display_customers(@customer_repository.all)
    customer_id = @order_view.ask_for("Customer ID")
    @customer_repository.find(customer_id)
  end

  def build_employee
    @order_view.display_employees(@employee_repository.all_delivery_guys)
    employee_id = @order_view.ask_for("Employee ID")
    @employee_repository.find(employee_id)
  end
end

# meal_repository = MealRepository.new("data/meals.csv")
# customer_repository = CustomerRepository.new("data/customers.csv")
# employee_repository = EmployeeRepository.new("data/employees.csv")
# order_repository = OrderRepository.new("data/orders.csv", meal_repository, customer_repository, employee_repository)

# controller = OrdersController.new(meal_repository, employee_repository, customer_repository, order_repository)
