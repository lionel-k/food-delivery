require_relative '../views/customer_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomerView.new
  end

  def list
    customers = @customer_repository.all
    @customer_view.display(customers)
  end

  def add
    customer_name = @customer_view.ask_customer_attribute("name")
    customer_address = @customer_view.ask_customer_attribute("address")
    customer = Customer.new(name: customer_name, address: customer_address)
    @customer_repository.add(customer)
  end

  def delete
    list
    customer_id = @customer_view.ask_customer_attribute("ID")
    customer = @customer_repository.find(customer_id.to_i)
    @customer_repository.delete(customer)
  end
end
