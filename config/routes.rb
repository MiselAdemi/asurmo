Rails.application.routes.draw do
  resources :activities
  devise_for :users, :controllers => { registrations: 'registrations' }

  authenticated :user do
    root 'organizations#new', as: :authenticated_root
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  resources :users do
    put "update_avatar", :as => "update_avatar"
  end

  resources :organizations do
    resources :moderators
  end
end
