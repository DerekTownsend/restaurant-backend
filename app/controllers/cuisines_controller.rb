class CuisinesController < ApplicationController
  # skip_before_action :authorized, only: [:index, :show, :search]

  def index
    cuisines = Cuisine.all
    render json: {cuisines: cuisines}
  end

  def show
    cuisine = Cuisine.find_by(id: params[:id])
    page = params["page"]
    page = page.to_i
    ending_page = page*24
    starting_page = ending_page-24
    restaurants = cuisine.restaurants
    restaurants_max = restaurants.count

    if restaurants
      restaurants = restaurants[starting_page...ending_page]
      # p " WHAT THE FUCK#{restaurants}"
      restaurants = JSON.parse(RestaurantSerializer.new(restaurants, restaurants_max).to_serialized_json)
      # p restaurants
      render json:  {cuisine: cuisine, restaurants: restaurants}
    else
      render json: {restaurants: []}
    end
    # total: Restaurant.all.count

    # restaurants = JSON.parse(RestaurantSerializer.new(restaurants.to_a, restaurants_max).to_serialized_json)["restaurants"]
    # p restaurants["restaurants"]
  end
end
