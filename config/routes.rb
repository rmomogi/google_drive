Rails.application.routes.draw do
  root 'sessions#index'

  get "/users/sign_in" => redirect("/")

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  resources :documents

  unauthenticated do
    root :to => 'sessions#index'
  end

  authenticated do
    root :to => 'dashboard#index'
  end

  get 'dashboard', to: 'dashboard#index'
  get 'dashboard/configuration', to: 'dashboard#configuration'
end
