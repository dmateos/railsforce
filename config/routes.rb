Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"

  resources :graphs

  namespace :api do
    namespace :v1 do
      resources :graphs
    end
  end
end
