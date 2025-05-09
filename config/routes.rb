Rails.application.routes.draw do
  resources :user_stocks, only: [ :create, :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check
  get "portfolio", to: "users#portfolio"
  root "pages#home"
  post "portfolio", to: "users#portfolio"
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
end
