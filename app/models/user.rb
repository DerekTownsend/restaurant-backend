class User < ApplicationRecord
  has_secure_password
  has_many :restaurants
  has_many :favorites, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :restaurant_favorites, through: :favorites, source: :restaurant
  has_many :restaurant_ratings, through: :ratings, source: :restaurant
  has_many :restaurant_reviews, through: :reviews, source: :restaurant
  has_many :review_replies, through: :replies, source: :review
end
