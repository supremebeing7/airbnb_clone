AirbnbClone::Application.routes.draw do
  devise_for :users
  root to: "users#index"

  resources :rooms

end
