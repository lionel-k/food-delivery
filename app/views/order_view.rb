class OrderView
  def display_orders(orders)
    orders.each do |order|
      message = "Order ID #{order.id}: Customer: #{order.customer.name} - #{order.meal.name}"
      message += "\n\t Assigned to Employee: #{order.employee.username.capitalize}\n"
      puts message
    end
  end

  def ask_for(item)
    puts ""
    puts "Which #{item} would you like ?"
    print "> "
    gets.chomp.to_i
  end

  def display_meals(meals)
    meals.each do |meal|
      puts "Meal ID #{meal.id}: #{meal.name} - #{meal.price}€"
    end
  end

  def display_customers(customers)
    customers.each do |customer|
      puts "Customer ID #{customer.id}: #{customer.name} - #{customer.address}"
    end
  end

  def display_employees(employees)
    employees.each do |employee|
      puts "Employee ID #{employee.id}: #{employee.username.capitalize}"
    end
  end

  def wrong_order_id
    puts "Wrong Order ID.. Try again.."
    puts ""
  end
end
