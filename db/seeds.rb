# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
josh = Chef.create(name: "Josh Tukman")

salt = Ingredient.create!(name: "salt", calories: 10)
pasta = Ingredient.create!(name: "pasta", calories: 100)
sauce = Ingredient.create!(name: "tomato sauce", calories: 80)
cheese = Ingredient.create!(name: "mozzarella cheese", calories: 150)
bread = Ingredient.create!(name: "pizza dough", calories: 140)

spaghetti = josh.dishes.create!(name: "Spaghetti", description: "A delicious classic pasta dish from the Southern Italy")
pizza = josh.dishes.create!(name: "Pizza", description: "A fantastic blend of flavors and a huge hit with kids")
chic_parm = josh.dishes.create!(name: "Chicken Parmesan", description: "A hearty dish with tender chicken and real parmesan cheese")

DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: salt.id)
DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id)
