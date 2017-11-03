class CustomerView
  def display(customers)
    customers.each do |customer|
      puts "Customer ID #{customer.id}: #{customer.name} - #{customer.address}"
    end
  end

  def ask_customer_attribute(attribute)
    puts "What is the #{attribute} of the customer ?"
    print "> "
    gets.chomp
  end
end
