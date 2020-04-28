class Restaurant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :menu_items
  has_many :favorites
  has_many :ratings
  has_many :reviews
  has_many :user_favorites, through: :favorites, source: :user
  has_many :user_ratings, through: :ratings, source: :user
  has_many :user_reviews, through: :reviews, source: :user

  def get_rating
    score = 0
    self.ratings.each do |rating|
      score += rating.amount
    end
    if self.ratings.count == 0
      score
    else
      score/self.ratings.count
    end
  end

end
