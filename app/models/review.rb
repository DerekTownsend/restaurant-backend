class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :replies, dependent: :destroy
  has_many :user_replies, through: :replies, source: :user

end
