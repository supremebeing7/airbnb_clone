AirbnbClone::Application.routes.draw do
  devise_for :users
  root to: "rooms#index"

  resources :rooms do
    resources :pictures
  end

  resources :bookings, only: [:create]
  resources :ratings, only: [:create, :update]

end
