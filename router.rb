class Router
  def initialize(meals_controller, customers_controller, employee_repository, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @employee_repository = employee_repository
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run
    puts "Welcome to the Food Delivery app!"
    puts "           --           "
    puts ""

    @employee = @sessions_controller.sign_in

    while @employee
      display_menu(@employee)
      action = gets.chomp.to_i
      print `clear`
      route_action(action, @employee)
    end
  end

  private

  def route_action(action, employee)
    employee.role == "manager" ? actions_manager(action) : actions_delivery_guy(action)
  end

  def actions_manager(action)
    if (1..8).to_a.include? action
      meals_action(action) if [1, 2, 7].include? action
      customers_action(action) if [3, 4, 8].include? action
      orders_action(action) if [5, 6].include? action
    elsif action.zero?
      @employee = nil
    else
      puts "Please press #{(1..8).to_a.join(', ')} or 0"
    end
  end

  def meals_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 7 then @meals_controller.delete
    end
  end

  def customers_action(action)
    case action
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 8 then @customers_controller.delete
    end
  end

  def orders_action(action)
    case action
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    end
  end

  def actions_delivery_guy(action)
    case action
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 0 then @employee = nil
    else
      puts "Please press #{(1..2).to_a.join(', ')} or 0"
    end
  end

  def display_menu(employee)
    puts ""
    puts "What do you want to do ?"
    employee.role == "manager" ? display_menu_manager : display_menu_delivery_guy
    puts "0 - Stop and exit the program"
  end

  def display_menu_manager
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "5 - List all the undelivered orders"
    puts "6 - Create an order for a customer and assign it to a delivery guy"
    puts "7 - Delete a meal"
    puts "8 - Delete a customer"
  end

  def display_menu_delivery_guy
    puts "1 - List my undelivered orders"
    puts "2 - Mark an order as delivered"
  end
end
