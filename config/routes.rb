Rails.application.routes.draw do
  resources :activities
  devise_for :users, :controllers => { registrations: 'registrations' }

  authenticated :user do
    root 'organizations#new', as: :authenticated_root
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  resources :users, :path => "" do
    put "update_avatar", :as => "update_avatar"
    put "upload_cover", :as => "upload_cover"
    get "about", :as => "about"

    get "organizations/index", :as => "organizations", :path => "organizations"

    resources :statuses
  end

  resources :organizations, :except => [:index] do
    resources :members, :only => [:create, :destroy]

    resources :campains do
      resources :events
    end
  end

  namespace :admin do
    get 'dashboard/index'
    resource :users
  end

  scope ":profile_name" do
    resources :albums do
      resources :pictures
    end
  end

end
