require 'rails_helper'

RSpec.describe "As a visitor" do
    describe "when I visit the dish show page" do
        it "shows all the ingredients for that dish and the chef's name" do
            josh = Chef.create(name: "Josh Tukman")

            spaghetti = josh.dishes.create!(name: "Spaghetti", description: "A delicious classic pasta dish from the Southern Italy")
            pizza = josh.dishes.create!(name: "Pizza", description: "A fantastic blend of flavors and a huge hit with kids")
            chic_parm = josh.dishes.create!(name: "Chicken Parmesan", description: "A hearty dish with tender chicken and real parmesan cheese")

            salt = Ingredient.create!(name: "salt", calories: 10)
            pasta = Ingredient.create!(name: "pasta", calories: 100)
            sauce = Ingredient.create!(name: "tomato sauce", calories: 80)

            DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: salt.id)
            DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
            DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id) 
            
            visit "/dishes/#{spaghetti.id}"

            expect(page).to have_content(spaghetti.name)
            expect(page).to have_content("List of Ingredients:")
            expect(page).to have_content(salt.name)
            expect(page).to have_content(pasta.name)
            expect(page).to have_content(sauce.name)
            expect(page).to have_content("Created by world renowned chef #{josh.name}")
            
            expect(page).to_not have_content(pizza.name)
        end

        it 'I can see the total calorie count for that dish' do
            josh = Chef.create(name: "Josh Tukman")

            spaghetti = josh.dishes.create!(name: "Spaghetti", description: "A delicious classic pasta dish from the Southern Italy")
            pizza = josh.dishes.create!(name: "Pizza", description: "A fantastic blend of flavors and a huge hit with kids")
            chic_parm = josh.dishes.create!(name: "Chicken Parmesan", description: "A hearty dish with tender chicken and real parmesan cheese")

            salt = Ingredient.create!(name: "salt", calories: 10)
            pasta = Ingredient.create!(name: "pasta", calories: 100)
            sauce = Ingredient.create!(name: "tomato sauce", calories: 80)

            DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: salt.id)
            DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
            DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id) 

            visit "/dishes/#{spaghetti.id}"

            expect(page).to have_content("Total Calories for this dish: 190")
        end
    end
end