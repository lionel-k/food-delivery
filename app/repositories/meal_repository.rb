require 'csv'
require_relative '../models/meal.rb'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    @meals = []
    load_csv
  end

  def add(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def all
    @meals
  end

  def find(meal_id)
    @meals.find { |meal| meal.id == meal_id }
  end

  def delete(meal)
    @meals.delete(meal)
    save_csv
  end

  private

  def load_csv
    File.open(@csv_file_path, 'w').close unless File.exist? @csv_file_path

    CSV.foreach(@csv_file_path, @csv_options) do |row|
      row[:id]    = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb', @csv_options) do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
