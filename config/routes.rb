Rails.application.routes.draw do
  resources :home, only: [:index]
  get "/:mine/:theirs" => "home#index"

  root "home#index"
end
