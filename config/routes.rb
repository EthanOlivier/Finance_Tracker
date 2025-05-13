Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "pages#home"
  get "portfolio", to: "users#portfolio"
  post "portfolio", to: "users#portfolio"
  get "friends", to: "users#friends"
  post "friends", to: "users#friends"
  post "/users/:id/create_friend/:friend_id", to: "users#create_friend", as: "create_friend"
  delete "/users/:id/remove_friend/:friend_id", to: "users#remove_friend", as: "remove_friend"
  resources :user_stocks, only: [ :create, :destroy ]
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
end
