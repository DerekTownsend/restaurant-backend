class RatingsController < ApplicationController
  def create
    rating = Rating.create(rating_params)
    render json: RestaurantSerializer.new(rating.restaurant).to_serialized_json
  end

  def update
    rating = Rating.find_by(id: params[:id])
    rating.update_attributes(rating_params)
    render json: RestaurantSerializer.new(rating.restaurant).to_serialized_json
  end

  def destroy
    rating = Rating.find_by(id: params[:id])
    restaurant = rating.restaurant
    rating.destroy
    render json: RestaurantSerializer.new(restaurant).to_serialized_json
  end


  private
  def rating_params
    params.require(:rating).permit(:amount, :user_id, :restaurant_id)
  end
end
