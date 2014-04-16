AirbnbClone::Application.routes.draw do
  devise_for :users
  root to: "rooms#index"

  resources :rooms do
    resources :pictures
  end
end
