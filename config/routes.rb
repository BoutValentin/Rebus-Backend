Rails.application.routes.draw do
  resources :users
  post 'login', to: 'authentication#login'
  resources :icons
  resources :syllable_letters
  resources :phonetics
  mount Avo::Engine, at: Avo.configuration.root_path
  get 'rebus/random'
  get 'rebus/word', to: 'rebus#word', as: :rebus_word
  post 'rebus/:id/guess', to: 'rebus#guess'
  post 'rebus/:id/pass', to: 'rebus#pass'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#home"
end
