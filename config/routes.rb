Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/spotify/callback', to: 'users#spotify'
  get '/auth/google_oauth2/callback', to: 'users#youtube'
  get '/youtube', to: 'users#youtube'
  get '/spotify', to: 'users#spotify'

  root 'home#index'
end
