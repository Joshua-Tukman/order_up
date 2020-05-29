require 'rails_helper' 

RSpec.describe "As a visitor" do
    describe "when I visit the chef's show page" do
        it "I see the name of that chef and a link to an index page for all the ingredients that chef uses in their dishes" do
            josh = Chef.create(name: "Josh Tukman")
            ed = Chef.create(name: "Ed Mitchell")

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

            visit "/chefs/#{josh.id}"

            expect(page).to have_content("Josh Tukman")
            
            click_link "All ingredients used in these dishes"

            expect(current_path).to eq("/chefs/#{josh.id}/ingredients")
            expect(page).to have_content(salt.name)
            expect(page).to have_content(pasta.name)
            expect(page).to have_content(sauce.name)
            expect(page).to have_content(cheese.name)
            expect(page).to have_content(bread.name)
            expect(page).to have_content(chicken.name)

        end
    end
end