Rails.application.routes.draw do
  resources :search_suggestions
  resources :activities
  devise_for :users, :controllers => { registrations: 'registrations' }

  authenticated :user do
    root 'organizations#new', as: :authenticated_root
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  constraints("conversations") do
    resources :users, :path => "" do
      put "update_avatar", :as => "update_avatar"
      put "upload_cover", :as => "upload_cover"
      get "about", :as => "about"

      get "organizations/index", :as => "organizations", :path => "organizations"

      resources :statuses do
        member do
          put "support" => "statuses#support"
        end
      end
    end
  end

  resources :comments

  resources :conversations do
    resources :messages
  end

  resources :organizations, :except => [:index] do
    #resources :members
    post "members/create_admin", :as => "create_admin", :path => "admins"
    get "members/remove_admin/:user" => "members#remove_admin", :as => "remove_admin", :path => "admins/:user"

    post "members/create_moderator", :as => "create_moderator", :path => "moderators"
    get "members/remove_moderator/:user" => "members#remove_moderator", :as => "remove_moderator", :path => "admins/:user"

    get "organizations/show_admins", :as => "show_admins", :path => "admins"
    get "organizations/show_moderators", :as => "show_moderators", :path => "moderators"
    get "organizations/show_members", :as => "show_members", :path => "members"
    get :autocomplete

    resources :campains do
      collection do
        resources :events, :only => [:index]
      end

      resources :events, :except => [:index]
      get "events/campain_events", :as => "all_events", :path => "events"
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
