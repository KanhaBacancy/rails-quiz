Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'

  namespace :api do
    namespace :v1 do
      resources :companies, only: [:create]
    end
  end
end
