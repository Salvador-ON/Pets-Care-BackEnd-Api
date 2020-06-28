Rails.application.routes.draw do
  resources :services,  only: [:index, :create, :destroy]
  resources :appointments, only: [:index, :create, :destroy]
  # resources :sessions, only: [:create]
  # resources :users, only: [:create]
  delete :logout, to: "sessions#destroy"
  get :logged_in, to: "sessions#logged_in"
  post :signup, to: "users#new"
  post :signin, to: "sessions#create"
  # post :appointments, to: "appointments#create"
  post :services, to: "services#create"
  get :services, to: "services#index"
  get :availables, to: "availables#index"
  # get :appointments, to: "appointments#index"
  # DELETE :APPOINTMENTS, TO: "APPOINTMENTS#DESTROY"
end
