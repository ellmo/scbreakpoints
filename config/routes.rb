Rails.application.routes.draw do
  Healthcheck.routes(self)
  resources :home, only: [:index]
  get "/:combatants" => "home#index"

  root "home#index"
end
