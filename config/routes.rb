Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # PARTE 1
  get '/directors', to: 'director#index'
  post '/directors', to: 'director#create'
  get '/director/:id', to: 'director#show'
  delete '/director/:id', to: 'director#destroy'
  delete '/directors', to: 'director#destroy_all'
  get '/directors/oscars', to: 'director#oscars'

  # PARTE 2
  get 'movies', to: 'movie#index'
  post '/movies', to: 'movie#create'
  get '/director/:director_id/movies', to: 'movie#director'
  post '/director/:director_id/movies', to: 'movie#create'
  patch '/director/:director_id/movies/:movie_id', to: 'movie#update'
  get '/movies/sinopsis/:keyword', to: 'movie#find'

  # PARTE 3
  post '/ranking/:director_id', to: 'ranking#create'  
  get '/ranking/:director_id', to: 'ranking#director'
  get '/ranking/top/:quantity', to: 'ranking#top'
  get '/movies/:movie_id/director/rankings', to: 'ranking#directorRankings'
  delete '/director/ranking/low', to: 'ranking#deleteLow'
  get '/ranking/pages/all', to: 'ranking#all'

end
