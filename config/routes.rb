Rails.application.routes.draw do
  resources :user_stocks, only: [ :create, :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check
  get "portfolio", to: "users#portfolio"
  post "portfolio", to: "users#portfolio"
  get "friends", to: "users#friends"
  delete "/users/:id/remove_friend/:friend_id", to: "users#remove_friend", as: "remove_friend"
  root "pages#home"
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
end
