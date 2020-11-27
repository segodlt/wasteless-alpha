Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :recipes do
    resources :measures, only: [ :new, :create, :destroy ]
  end

  resources :categories, only: [:index, :show]
  resources :ingredients, only: [:index, :show]
  # resources :create_recipe_sbs do
  #   resources :measures
  # end

end
