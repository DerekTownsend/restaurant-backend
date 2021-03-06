class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :address, :city, :zipcode, :thumbnail, :zomato_id

  def initialize(restaurant_object, total = Restaurant.all.count)
    @restaurant = restaurant_object
    @total = total
  end

  def to_serialized_json
    # puts "ALLL MOVIES #{@restaurant}"
    # puts @restaurant
    # puts "========================"
    final_rating = []

    if @restaurant.class == Array
      # puts "=============================================="
      # puts @restaurant.class
      # puts [].class

      obj =
      {
        except: %i[ created_at updated_at bio user_id zomato_id]
      }
      final_rating = @restaurant.collect do |rest|
         rest.get_rating()
       end

    else

      obj =
      {
        except: %i[ created_at updated_at]
      }
      final_rating = @restaurant.get_rating()
    end
# {restaurants: @restaurant, total: @total, final_rating: final_rating}

    @restaurant.to_json(obj)
  end

end
