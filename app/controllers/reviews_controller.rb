class ReviewsController < ApplicationController
  # skip_before_action :authorized, only: [:index, :create]

  def index
    reviews = Review.all
    render json: {reviews: reviews}
  end

  def create
    puts "HEEEEEEEEEEERRRRRRRRREEEEEEEEEEEEEEE"
    review = Review.create(review_params)
    puts ReviewSerializer.new(review).to_serialized_json
    render json: ReviewSerializer.new(review).to_serialized_json
  end

  def update
    review = Review.find_by(id: params[:id])
    review.update_attributes(review_params)
    render json: ReviewSerializer.new(review).to_serialized_json
  end

  def destroy
    review = Review.find_by(id: params[:id])
    review.destroy
    render json: {message: "success"}
  end
  private
  def review_params
    params.require(:review).permit(:title, :message, :user_id, :restaurant_id)
  end
end
