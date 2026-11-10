Rails.application.routes.draw do
  resources :movies

  # Primary route expected by Gradescope autograder
  get  '/search', to: 'movies#search_tmdb', as: 'search_tmdb'
  post '/search', to: 'movies#search_tmdb'

  # Route aliases
  get  '/search_tmdb', to: 'movies#search_tmdb'
  post '/search_tmdb', to: 'movies#search_tmdb'

  post '/add_movie', to: 'movies#add_movie', as: 'add_movie'
  root to: redirect('/movies')
end