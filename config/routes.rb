Rails.application.routes.draw do
  resources :search_suggestions
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
    resources :members
    post "members/create_admin", :as => "create_admin", :path => "admins"
    get "members/remove_admin/:user" => "members#remove_admin", :as => "remove_admin", :path => "admins/:user"

    get "organizations/show_admins", :as => "show_admins", :path => "admins"
    get :autocomplete

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
