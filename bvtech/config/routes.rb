Rails.application.routes.draw do
  namespace :admin do
      resources :sports
      resources :events
      resources :markets

      root to: "sports#index"
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
