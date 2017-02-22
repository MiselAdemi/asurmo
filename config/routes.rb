Rails.application.routes.draw do
  resources :activities
  devise_for :users, :controllers => { registrations: 'registrations' }

  as :user do
    #get "/:id" , :to => "users#show", :as => "user_path"
  end

  authenticated :user do
    root 'organizations#new', as: :authenticated_root
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  resources :users do
    put "update_avatar", :as => "update_avatar"
    get "about", :as => "about"
    resources :statuses
  end

  resources :organizations do
    resources :members
    put "join/:user_id", :to => "organizations#join_member", :as => "join"
    delete "unjoin/:user_id", :to => "organizations#remove_member", :as => "unjoin"

    resources :campains
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
