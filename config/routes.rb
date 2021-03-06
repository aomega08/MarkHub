Rails.application.routes.draw do
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/dashboard', to: 'dashboard#index', as: :dashboard
  resources :teams do
    post :choose, on: :member
  end

  resources :twitter, only: :show

  namespace :oauth do
    get 'facebook/choose', to: 'facebook#index', as: :choose_facebook_pages
    match 'facebook/pages', via: [:get, :post], to: 'facebook#pages', as: :add_facebook_pages

    get 'twitter', to: 'twitter#new', as: :add_twitter_account
    get 'twitter/callback', to: 'twitter#create', as: :twitter_callback
  end
end
