
Reply.destroy_all
Rating.destroy_all
Review.destroy_all
RestaurantCuisine.destroy_all
Cuisine.destroy_all
Favorite.destroy_all
Ingredient.destroy_all
MenuItem.destroy_all
Restaurant.destroy_all
User.destroy_all

@apikey = "d6e8e880c56079b8402c4e1b689e0cbe"
@api_city = "292"

# =========================================================== Seeder

# User.create(username:"zomato", first_name: "zomato", last_name:"zomato", email:"zomato@gmail.com", password:"zomato")
#
# Cuisine.create(name:"Pizza")
#
# Restaurant.create(name: "Hommie Bakery", bio: "The whole world is in our hands. And hommie don't play that stuff. I am the best iteration of this bakery I am alpha and omega.", address: "6789 S Detroit Ave", zipcode: "60666", city: "Detroit")
#
# Restaurant.first.cuisines << Cuisine.first
# # Restaurant.create(name: "Da Man's House", bio: "The whole world is in our hands. And hommie don't play that stuff. I am the best iteration of this bakery I am alpha and omega.", address: "6789 S Detroit Ave", zipcode: "60666", cuisine: "Fast Food", user: User.first)
# =========================================================== Seeder

@comments = [
   "This Movie is pretty good. It was heart warming thought provoking and really made me think deeply about the human condition and what it means to be human. My eyes have never been this opened by a peice of media. I feel truely awakened.",

  "Pirates are evil? The Marines are righteous? These terms have always changed throughout the course of history! Kids who have never seen peace and kids who have never seen war have different values! Those who stand at the top determine what's wrong and what's right! This very place is neutral ground! Justice will prevail, you say? But of course it will! Whoever wins this war becomes justice!",

  "Once, the Lord of Light banished Dark, and all that stemmed from humanity. And men assumed a fleeting form. These are the roots of our world. Men are props on the stage of life, and no matter how tender, how exquisite... A lie will remain a lie!",

  "I may be but small, but I will die a colossus.",

  "The dragons shall never be forgotten… We knights fought valiantly, but for every one of them, we lost three score of our own. Exhiliration, pride, hatred, rage… The dragons teased out our dearest emotions. ... Thou will understand, one day. At thy twilight, old thoughts return, in great waves of nostalgia",

  "Brother, unyielding sword of Lothric's Prince. Rise, if you would... For that is our curse",

  "I love heroes, but I don't want to be one. Do you even know what a hero is!? For example, you have some meat. Pirates will feast on the meat, but the hero will distribute it among the people! I want to eat the meat",

  "Don't ever think there's any perfect society made by humans!! If you think that way you'll overlook the enemy!! Don't be fooled by appearances!!",

  "If I can't even protect my captain's dream, then whatever ambition I have is nothing but talk! Luffy must be the man who becomes the Pirate King!",

  "Compared to the 'righteous' greed of the rulers, the criminals of the world seem much more honorable. When scum rules the world, only more scum is born.",

  "When do you think people die? When they are shot through the heart by the bullet of a pistol? No. When they are ravaged by an incurable disease? No... It’s when they're forgotten!",

  "The cake is a lie",

  "A man chooses! A slave obeys!",

  "What do the numbers mean, Mason?",

  "Tonight, Gehrman join the hunt",

  "Farewell, good Hunter. May you find your worth in the waking world.",

  "Curse here, Curse there. Curse for he and she, why care? A bottomless curse, a bottomless sea, source of all greatness, all things that be. Listen for the baneful chants. Weep with them, as one in trance. And weep with us, oh, weep with us.",

  "Hunters have told me about the church. About the gods, and their love. But... do the gods love their creations? I am a doll, created by you humans. Would you ever think to love me? Of course... I do love you. Isn't that how you've made me?",

  "Die! Die, die! Hunters are killers, nothing less! You call ME a beast? A Beast!? What would you know? I didn't ask for this!",

  "Acts of goodness are not always wise, and acts of evil are not always foolish, but regardless, we shall always strive to be good.",

  "Again and again, it never ends...Please, I need you to do something...this village is the true secret. Testament to the old sins. It feeds this Hunter's nightmare...Please, bring an end to the horror. So our forefathers sinned? We hunters cannot bear their weight forever...it isn't fair...it just isn't fair.",

  "Do you know why the Hunters are drawn to this Nightmare? Because it sprouted from their very misdeeds. Things that some would rather keep secret. A pitiful tale of petty arrogance, really."
 ]
@titles = [
   "That restaurant was totally tubular",
   "Thats gonna be a yikes from me",
   "You either yeet or get yeeted",
   "Bruce Wayne Did nothing wrong",
   "Whats a pony my dude",
   "That was wickity wickity wack",
   "You'll never see it coming",
   "Some gansta is dissin' your flygirl",
   "Somebody once told me the world is gonna roll me",
   "What is america",
   "Who is america",
   "Why is america",
   "Language",
   "Thats my Secret Cap, im always Angry",
   "I lost the kid",
   "I don't feel so good Mr. Stark"
 ]

# Restaurant.first
# Review.create(title: titles.sample, message: comments.sample , user: User.first, restaurant: Restaurant.first)

# =========================================================== Seeder
# Favorite.create(user: User.first, restaurant: Restaurant.first)
#
# # Ingredient.create()
#   MenuItem.create(name:"BLT", price: 6.50, restaurant: Restaurant.first)
#
# Ingredient.create(name:"lettuce", amount:2, measurement:"cups", menu_item: MenuItem.first)
# Ingredient.create(name:"tomato", amount:2, measurement:"slices", menu_item: MenuItem.first)
# Ingredient.create(name:"bacon", amount:12, measurement:"pieces", menu_item: MenuItem.first)
#
#
# rating_amounts = (65...100).to_a
#
# Rating.create(amount: rating_amounts.sample , user: User.first, restaurant: Restaurant.first)
# =========================================================== Seeder


def initial_parse
  # page = 291
  # term = "restaurant"
  # restaurant max pages
  # max_pages=351
  # term = "dance"
  # page = 123
  # max_pages=201
  # while page <= max_pages do
    # puts "CURRENT PAGE #{page}"
    restaurant_data = RestClient.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{@api_city}&entity_type=city&start=2", {user_key: @apikey})
    parsed_restaurant_data = JSON.parse(restaurant_data)['restaurants']
    # puts parsed_restaurant_data
    more_detailed_search(parsed_restaurant_data)
    # page+=1
  # end
end

def more_detailed_search(parsed_restaurant_data)
  parsed_restaurant_data.each do |restaurant|
    # id = restaurant['imdbID']
    # data = RestClient.get("http://www.omdbapi.com/?i=#{id}&apikey=#{@apikey}")
    movie_data = restaurant["restaurant"]
    # puts "Here #{["id"]}"
    # puts movie_data
    name = movie_data['name']
    address = movie_data["location"]['address']
    city = movie_data["location"]['city']
    zipcode = movie_data["location"]['zipcode']
    cuisines = movie_data['cuisines']
    thumbnail = movie_data['thumb']
    zomato_id = movie_data['id']

    cuisine_list = create_cuisines(cuisines.split(", "))

    created_restaurant = Restaurant.create(name: name, address: address, city: city, zipcode: zipcode,  thumbnail: thumbnail, zomato_id: zomato_id, user: User.first)
    #
    created_restaurant.cuisines << cuisine_list
  end
end

def create_cuisines(cuisines)
  cuisines.collect do |cuisine_name|
    Cuisine.find_or_create_by(name: cuisine_name)
  end
end

def seed_restaurants
  Restaurant.all.each do |restaurant|
    (2..6).to_a.sample.times do
      Review.create(title: @titles.sample, message: @comments.sample, user: User.first, restaurant: restaurant)
    end
  end

 # Seeding Ratings
 rating_amounts = (65...100).to_a
 Restaurant.all.each do |restaurant|
     Rating.create(amount: rating_amounts.sample , user: User.first, restaurant: restaurant)
 end

 Review.all.each do |review|
   (1..3).to_a.sample.times do
     Reply.create(message: @comments.sample, review: review, user: User.all.sample)
   end
 end

end

# Movie.all.each do |restaurant|
#   actors = restaurant.actors.uniq
#   restaurant.actors.destroy_all
#   restaurant.actors << actors
# end

# if Movie.all.count == 0
#   initial_parse
# end

initial_parse
seed_restaurants
