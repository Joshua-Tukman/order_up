require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :dishes}
  end

  describe "#ingredients_used" do
    it "can list all ingredients in dishes made by the chef" do
      josh = Chef.create(name: "Josh Tukman")
            
      spaghetti = josh.dishes.create!(name: "Spaghetti", description: "A delicious classic pasta dish from the Southern Italy")
      pizza = josh.dishes.create!(name: "Pizza", description: "A fantastic blend of flavors and a huge hit with kids")
      chic_parm = josh.dishes.create!(name: "Chicken Parmesan", description: "A hearty dish with tender chicken and real parmesan cheese")

      salt = Ingredient.create!(name: "salt", calories: 10)
      pasta = Ingredient.create!(name: "pasta", calories: 100)
      sauce = Ingredient.create!(name: "tomato sauce", calories: 80)
      cheese = Ingredient.create!(name: "mozzarella cheese", calories: 150)
      bread = Ingredient.create!(name: "pizza dough", calories: 140)
      chicken = Ingredient.create!(name: "fresh chicken", calories: 250)

      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: salt.id)
      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id)

      DishIngredient.create!(dish_id: pizza.id, ingredient_id: sauce.id) 
      DishIngredient.create!(dish_id: pizza.id, ingredient_id: cheese.id) 
      DishIngredient.create!(dish_id: pizza.id, ingredient_id: bread.id) 

      DishIngredient.create!(dish_id: chic_parm.id, ingredient_id: chicken.id) 
      DishIngredient.create!(dish_id: chic_parm.id, ingredient_id: sauce.id) 
      DishIngredient.create!(dish_id: chic_parm.id, ingredient_id: cheese.id) 

      expect(josh.ingredients_used).to eq([salt.name, pasta.name, sauce.name, cheese.name, bread.name, chicken.name])
    end 
  end 
end
