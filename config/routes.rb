Rails.application.routes.draw do
  Healthcheck.routes(self)
  resources :home, only: [:index]

  namespace :api do
    resource :parse, only: [:index]
  end

  get "/api/parse/:combatants" => "api/parse#index"
  get "/:combatants" => "home#index"

  root "home#index"
end
