Rails.application.routes.draw do
  resources :services,  only: [:index, :create, :destroy]
  resources :appointments, only: [:index, :create, :destroy]
  delete :logout, to: "sessions#destroy"
  get :logged_in, to: "sessions#logged_in"
  post :signup, to: "users#create"
  post :signin, to: "sessions#create"
  get :availables, to: "availables#index"
  get :dashboard, to: "dashboard#index"
end
