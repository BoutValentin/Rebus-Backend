Rails.application.routes.draw do
  # We mount the rswag doc to /api-docs
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Add all the REST root for an users
  resources :users
  # to a post on /login, we associate the action login of the authentication controller
  post 'login', to: 'authentication#login'
  # to a get on /login, we associate the action index of the authentication controller
  get 'login', to: 'authentication#index'
  # to a get on /logout, we associate the action logout of the authentication controller
  get 'logout', to: 'authentication#logout'
  # Add all the REST routes for icons resources
  resources :icons
  # Add all the REST routes for syllable_letters resources
  resources :syllable_letters
  # Add all the REST routes for phonetics resources
  resources :phonetics
  # We mount the admin to the routes we define in config
  mount Avo::Engine, at: Avo.configuration.root_path
  # We associate to a get request to /leaderboard the action leaderboard of the users controller
  get '/leaderboard', to: 'users#leaderboard'
  # We associate to a get request to /rebus/random the action random of the rebus controller
  get 'rebus/random'
  # We associate to a get request to /rebus/word the action word of the rebus controller
  get 'rebus/word', to: 'rebus#word', as: :rebus_word
  # We associate to a post request to rebus/:id/guess the action guess of the rebus controller
  post 'rebus/:id/guess', to: 'rebus#guess'
  # We associate to a post request to rebus/:id/pass the action pass of the rebus controller
  post 'rebus/:id/pass', to: 'rebus#pass'

  # Defines the root path route ("/")
  root "static_pages#home"
end
