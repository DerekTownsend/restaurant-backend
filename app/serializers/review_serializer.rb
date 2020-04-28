class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_one :user
  has_one :restaurant

  def initialize(review_object, reviews_max=nil)
    @review = review_object
    @reviews_max = reviews_max
  end

    def to_serialized_json

      obj =
      {
        include:
        {
          restaurant:{except: %i[ created_at updated_at ]},
          user:{only: %i[ id username ]},
        }
      }
      if @reviews_max
        {reviews: @review, total: @reviews_max}.to_json(obj)
      else
        @review.to_json(obj)
      end
    end

end
