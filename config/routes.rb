Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show]

  namespace :api do
    namespace :v1 do
      resources :recipes, only: [] do
        get 'search', on: :collection
      end
    end
  end
end
