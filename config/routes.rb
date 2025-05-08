Rails.application.routes.draw do
  resources :user_stocks
  get "up" => "rails/health#show", as: :rails_health_check
  root "users#portfolio"
  post "portfolio", to: "users#portfolio"
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
end
