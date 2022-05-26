Rails.application.routes.draw do
  Healthcheck.routes(self)
  resources :home, only: [:index]
  get "/:mine/:theirs" => "home#index"

  root "home#index"
end
