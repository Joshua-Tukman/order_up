class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def ingredients_used
    ingredients_list = []
    dishes.each do |dish|
      ingredients_list << dish.ingredients
    end 
    binding.pry
    ingredients_list.map{|ingredient|ingredient.name}
  end

end
