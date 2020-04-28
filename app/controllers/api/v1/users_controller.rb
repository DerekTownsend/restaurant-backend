class Api::V1::UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def profile
    user = current_user
    render json: UserSerializer.new(user).to_serialized_json, status: :accepted
  end

  def create
    # user = User.new(user_params)
    # puts user
    user = User.create(user_params)

    if user.valid?
      token = encode_token(user_id: user.id)
      render json: UserSerializer.new(user, token).to_serialized_json, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def favorite_restaurants
    page = params["page"]
    page = page.to_i
    ending_page = page*24
    starting_page = ending_page-24

    user = current_user

    restaurants_max = user.movie_favorites.count
    restaurants = user.movie_favorites[starting_page...ending_page]

    render json:  RestaurantSerializer.new(restaurants, restaurants_max).to_serialized_json
  end

  def reviews
    page = params["page"]
    page = page.to_i
    ending_page = page*24
    starting_page = ending_page-24

    user = current_user

    reviews_max = user.reviews.count
    reviews = user.reviews[starting_page...ending_page]

    render json:  ReviewSerializer.new(reviews, reviews_max).to_serialized_json
  end

  def ratings
    page = params["page"]
    page = page.to_i
    ending_page = page*24
    starting_page = ending_page-24

    user = current_user
    ratings_max = user.ratings.count
    ratings = user.ratings[starting_page...ending_page]

    render json:  RatingSerializer.new(ratings, ratings_max).to_serialized_json
  end

  private
  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :admin)
  end

end
