class RestaurantCuisine < ApplicationRecord
  belongs_to :cuisine
  belongs_to :restaurant
end
