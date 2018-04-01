Rails.application.routes.draw do
  resources :search_suggestions
  devise_for :users, :controllers => { registrations: 'registrations' }

  authenticated :user do
    root 'home#index', as: :authenticated_root
    post :auth, to: "authentication#create"
  end

  root 'home#index'
  get "home/get_cities", :as => "get_cities"

  resource :subscriptions, :except => [:new] do
    collection do
      get 'new/:plan', :to => "subscriptions#new", :as => 'new'
      post 'update_plan', :to => "subscriptions#update_plan", :as => 'update_plan'
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
    resources :users do
      member do
        get "block" => "users#block"
        get "unblock" => "users#unblock"
      end
    end

    resources :leads
  end

  namespace :administrator do
    get '/:id' => "pages#dashboard"

    resources "organizations", only: [ :edit, :update ] do
      resources :campaigns do
        resources :events
        resources :tasks do
          member do
            post "assign_user" => "tasks#assign_user", as: "assign_user"
            post "remove_assignee/:user_id" => "tasks#remove_assignee", as: "remove_assignee"
          end

          collection do
            put :complete
          end

          resources :statuses
        end

        member do
          get 'participant_users' => "campaigns#participant_users"
        end
      end

      resources :users
      resources :members, module: :organizations
      resources :teams do
        collection do
          post "join/:user_id" => 'teams#join', as: 'join'
          post "exit/:user_id" => 'teams#exit', as: 'exit'
        end
      end

      post "role/:user_id" => 'members#change_role', as: 'role'
    end
  end

  resources :comments

  resources :users, :path => "" do
    put "update_avatar", :as => "update_avatar"
    put "upload_cover", :as => "upload_cover"
    get "about", :as => "about"
    get "friends", :as => "friends"

    collection do
    	get "users" => "users#index"
    end

    resources :organizations, :only => [:index]

    resources :statuses do
			member do
		  	put "support" => "statuses#support"
			end
		end

    resources :friendships, only: [:create, :update, :destroy]
  end

  resources :organizations, :except => [:index] do
    post "create_admin" => "members#create_admin"
    get "remove_admin/:user" => "members#remove_admin", :as => "remove_admin"
    post "create_moderator" => "members#create_moderator", :as => "create_moderator"
    get "remove_moderator/:user" => "members#remove_moderator", :as => "remove_moderator"

    get "show_admins"
    get "show_moderators"
    get "show_members"

    post "join_member/:user_id" => "organizations#join_member", :as => "join_member"
    delete "remove_member/:user_id" => "organizations#remove_member", :as => "remove_member"

    get :autocomplete
    get "invite", :to => "home#invite_user"
    get "send_to_all", :to => "world_members#send_to_all"

    resources :campains do
      collection do
        resources :events, :only => [:index]
      end

      resources :events, :except => [:index] do
        resources :statuses do
          member do
            put "support" => "statuses#support"
          end
        end
      end

      get "events/campain_events" => 'events#campain_events', :as => "all_events"

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

    resources :world_members do
      get "open_info_modal", :to => "world_members#open_info_modal"
    end
  end

  scope ":user_id" do
    resources :albums do
      resources :pictures
    end
  end

  resources :leads
end
