Rails.application.routes.draw do
  resources :search_suggestions
  devise_for :users, :controllers => { registrations: 'registrations' }

  authenticated :user do
    root 'organizations#new', as: :authenticated_root
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  resources :subscriptions, :except => [:new] do
    collection do
      get 'new/:plan', :to => "subscriptions#new", :as => 'new'
    end
  end
  resource :card

  resources :activities do
    resource :like, module: :activities
  end

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :direct_messages

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  namespace :admin do
    get '/' => "dashboard#index"
    resources :users
  end

  resources :users, :path => "" do
    put "update_avatar", :as => "update_avatar"
    put "upload_cover", :as => "upload_cover"
    get "about", :as => "about"
    
    collection do
    	get "index", :path => "users"
    end

    resources :organizations, :only => [:index]
    
    resources :statuses do
			member do
		  	put "support" => "statuses#support"
			end
		end
  end

  resources :comments

  resources :organizations, :except => [:index] do
    #resources :members
    #post "members/create_admin", :as => "create_admin", :path => "admins"
    post "create_admin" => "members#create_admin"

    #get "members/remove_admin/:user" => "members#remove_admin", :as => "remove_admin", :path => "admins/:user"
    get "remove_admin/:user" => "members#remove_admin", :as => "remove_admin"

    post "create_moderator" => "members#create_moderator", :as => "create_moderator"
    #get "members/remove_moderator/:user" => "members#remove_moderator", :as => "remove_moderator", :path => "admins/:user"
    get "remove_moderator/:user" => "members#remove_moderator", :as => "remove_moderator"

    get "show_admins"
    get "show_moderators"
    get "show_members"

    post "join_member"
    delete "remove_member"

    get :autocomplete

    resources :campains do
      collection do
        resources :events, :only => [:index]
      end

      resources :events, :except => [:index]
      get "events/campain_events", :as => "all_events", :path => "events"
      
      resources :statuses do
				member do
					put "support" => "statuses#support"
				end
			end
    end
    
    resources :statuses do
			member do
		  	put "support" => "statuses#support"
			end
		end
  end

  scope ":user_id" do
    resources :albums do
      resources :pictures
    end
  end

end
