
Reply.destroy_all
Rating.destroy_all
Review.destroy_all
Favorite.destroy_all
Ingredient.destroy_all
MenuItem.destroy_all
Restaurant.destroy_all
User.destroy_all

@apikey = "d6e8e880c56079b8402c4e1b689e0cbe"
@city = "292"


User.create(username:"Micheal_is_King", first_name: "Micheal", last_name:"Alfred", email:"micheal@gmail.com", password:"password", admin:true)

Restaurant.create(name: "Hommie Bakery", bio: "The whole world is in our hands. And hommie don't play that stuff. I am the best iteration of this bakery I am alpha and omega.", address: "6789 S Detroit Ave", zipcode: "60666", cuisine: "Fast Food", city: "Detroit")

Restaurant.create(name: "Da Man's House", bio: "The whole world is in our hands. And hommie don't play that stuff. I am the best iteration of this bakery I am alpha and omega.", address: "6789 S Detroit Ave", zipcode: "60666", cuisine: "Fast Food", user: User.first)

comments = [
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
titles = [
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
Review.create(title: titles.sample, message: comments.sample , user: User.first, restaurant: Restaurant.first)

Favorite.create(user: User.first, restaurant: Restaurant.first)

# Ingredient.create()
  MenuItem.create(name:"BLT", price: 6.50, restaurant: Restaurant.first)

Ingredient.create(name:"lettuce", amount:2, measurement:"cups", menu_item: MenuItem.first)
Ingredient.create(name:"tomato", amount:2, measurement:"slices", menu_item: MenuItem.first)
Ingredient.create(name:"bacon", amount:12, measurement:"pieces", menu_item: MenuItem.first)


Reply.create(message: comments.sample, review: Review.first )
rating_amounts = (65...100).to_a

Rating.create(amount: rating_amounts.sample , user: User.first, restaurant: Restaurant.first)

# Review.destroy_all

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
    restaurant_data = RestClient.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{city}&entity_type=city", {user_key: @apikey})
    parsed_restaurant_data = JSON.parse(restaurant_data)['restaurants']
    # puts parsed_restaurant_data
    more_detailed_search(parsed_restaurant_data)
    # page+=1
  # end
end

def more_detailed_search(parsed_restaurant_data)
  parsed_restaurant_data.each do |restaurant|
    id = restaurant['imdbID']
    data = RestClient.get("http://www.omdbapi.com/?i=#{id}&apikey=#{@apikey}")
    parsed_data = JSON.parse(data)

    # puts parsed_data
    title = parsed_data['Title']
    year = parsed_data['Year']
    mpaa_rating = parsed_data['Rated']
    released_date = parsed_data['Released']
    director = parsed_data['Director']
    writer = parsed_data['Writer']
    plot = parsed_data['Plot']
    language = parsed_data['Language']
    country = parsed_data['Country']
    poster_url = parsed_data['Poster']
    producer = parsed_data['Production']

    genre_list = create_genres(parsed_data['Genre'].split(", "))
    actor_list=create_actors(parsed_data['Actors'].split(", "))

    created_restaurant = Movie.find_or_create_by(title: title, year: year, mpaa_rating: mpaa_rating, released_date: released_date, director: director, writer: writer, plot: plot, language: language, country: country, poster_url: poster_url, producer: producer)

    created_restaurant.actors << actor_list
    created_restaurant.genres << genre_list
  end
end

# def create_actors(actors)
#   actors.collect do |actor_name|
#     Actor.find_or_create_by(name: actor_name)
#   end
# end
#
# def create_genres(genres)
#   genres.collect do |genre_name|
#     Genre.find_or_create_by(name: genre_name)
#   end
# end

# Movie.all.each do |restaurant|
#   actors = restaurant.actors.uniq
#   restaurant.actors.destroy_all
#   restaurant.actors << actors
# end

# if Movie.all.count == 0
#   initial_parse
# end

initial_parse
