Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home' do
    resources :recipes, only: :index
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dashboard', to: 'pages#dashboard'
  get '/account', to: 'pages#account'
  get '/mesrecettes', to: 'recipes#index'

  resources :recipes do
    resources :create_recipe_sbs, only: [ :show, :update ], controller: 'create_recipe_sbs'
    resources :measures, only: [ :new, :create, :destroy ]
  end

  resources :categories, only: [:index, :show]
  resources :ingredients, only: [:index, :show]

end
