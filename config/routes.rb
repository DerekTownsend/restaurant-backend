Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :favorites
  resources :ingredients
  resources :menu_items
  resources :ratings
  resources :replies
  resources :reviews
  resources :cuisines
  post '/search', to: 'restaurants#search'
  resources :restaurants

  namespace :api do
      namespace :v1 do
        resources :users, only: [:create]
        get '/profile', to: 'users#profile'
        get '/favorites', to: 'users#favorite_restaurants'
        get '/comments', to: 'users#reviews'
        get '/ratings', to: 'users#ratings'
        post '/login', to: 'auth#create'

      end
    end
end
