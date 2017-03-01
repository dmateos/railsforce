Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => "/cable"

  root to: "pages#index"

  resources :graphs

  namespace :api do
    namespace :v1 do
      resources :graphs
      resources :data_sequences
    end
  end
end
