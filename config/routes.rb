Rails.application.routes.draw do
  resources :home, only: [:index]
  get "/:unit/:target" => "home#index"

  root "home#index"
end
