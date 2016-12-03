Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  authenticated :user do
    root 'organizations#new', as: :authenticated_root
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  resources :users
  resources :organizations do
    resources :moderators
  end
end
