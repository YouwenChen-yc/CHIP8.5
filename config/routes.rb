Rails.application.routes.draw do
  resources :movies
  post '/search_tmdb', to: 'movies#search_tmdb', as: 'search_tmdb'
  get  '/search_tmdb', to: 'movies#search_tmdb'
  post '/add_movie', to: 'movies#add_movie', as: 'add_movie'
  root to: redirect('/movies')
end