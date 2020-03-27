class Restaurant < ApplicationRecord
  has_many :menu_items
  has_many :favorites
  has_many :ratings
  has_many :reviews
  has_many :user_favorites, through: :favorites, source: :user
  has_many :user_ratings, through: :ratings, source: :user
  has_many :user_reviews, through: :reviews, source: :user

end
