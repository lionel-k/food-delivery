require_relative '../views/meal_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def list
    @meals = @meal_repository.all
    @view.display(@meals)
  end

  def add
    # ask the user the name and the price of the new meal
    meal_name = @view.ask_user_meal_attribute("name")
    meal_price = @view.ask_user_meal_attribute("price")
    meal = Meal.new(name: meal_name, price: meal_price.to_i)
    @meal_repository.add(meal)
  end

  def delete
    list
    meal_id = @view.ask_user_meal_attribute("ID")
    meal = @meal_repository.find(meal_id.to_i)
    @meal_repository.delete(meal)
  end
end
