Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :players, :controllers => { registrations: 'players/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "discover", to: "offers#discover"

  # Defines the root path route ("/")
  root "index#show"
end
