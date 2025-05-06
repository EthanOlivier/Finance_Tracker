Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root "pages#home"
  get "stocks/show"
  get "stocks/:symbol", to: "stocks#show", as: :stock
end
