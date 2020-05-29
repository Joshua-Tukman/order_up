require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "#calorie_count" do
    it "can give the total calories for all ingredients in dish" do

      josh = Chef.create(name: "Josh Tukman")

      spaghetti = josh.dishes.create!(name: "Spaghetti", description: "A delicious classic pasta dish from the Southern Italy")
    
      salt = Ingredient.create!(name: "salt", calories: 10)
      pasta = Ingredient.create!(name: "pasta", calories: 100)
      sauce = Ingredient.create!(name: "tomato sauce", calories: 80)

      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: salt.id)
      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id)

      expect(spaghetti.calorie_count).to eq(190)
    end
  end 
end
