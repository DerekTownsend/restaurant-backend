class RestaurantsController < ApplicationController
  # skip_before_action :authorized, only: [:index]

  def index
    page = params["page"]
    if page
      page = page.to_i
      ending_page = page*24
      starting_page = ending_page-24
      restaurants = Restaurant.all[starting_page...ending_page]
    else
      restaurants = Restaurant.all[0...24]
    end
    # total: Restaurant.all.count
    render json:  RestaurantSerializer.new(restaurants).to_serialized_json
  end

  def show
      restaurant = Restaurant.find_by(id: params[:id])

    # total: Restaurant.all.count
    render json:  RestaurantSerializer.new(restaurant).to_serialized_json
  end

  def search
    page = params["page"]
    page = page.to_i
    ending_page = page*24
    starting_page = ending_page-24

    restaurants = Restaurant.all.select do |restaurant|
      if restaurant.title.downcase.include?(params[:term].downcase)
        restaurant
      end
    end

    if restaurants
      restaurants_max = restaurants.count
      restaurants = restaurants[starting_page...ending_page]
      render json:  RestaurantSerializer.new(restaurants, restaurants_max).to_serialized_json
    else
      render json: {restaurants: []}
    end
  end
end
