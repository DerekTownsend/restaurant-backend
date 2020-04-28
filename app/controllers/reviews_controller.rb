class ReviewsController < ApplicationController
  def index
    reviews = Review.all
    render json: {reviews: reviews}
  end

  def create
    review = Review.create(review_params)
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
    params.require(:review).permit(:title, :message, :user_id, :movie_id)
  end
end
