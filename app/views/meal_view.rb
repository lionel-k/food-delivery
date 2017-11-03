class MealView
  def display(meals)
    meals.each do |meal|
      puts "Meal ID #{meal.id}: #{meal.name} - #{meal.price}€"
    end
  end

  def ask_user_meal_attribute(attribute)
    puts "What is the #{attribute} of the meal ?"
    print "> "
    gets.chomp
  end
end
