Rails.application.routes.draw do
  resources :services
  resources :appointments
  # resources :sessions, only: [:create]
  # resources :users, only: [:create]
  delete :logout, to: "sessions#destroy"
  get :logged_in, to: "sessions#logged_in"
  post :signup, to: "users#create"
  post :signin, to: "sessions#create"
  post :appointments, to: "appointments#create"
  get :appointments, to: "appointments#index"
end
