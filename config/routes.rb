Rails3BootstrapDeviseCancan::Application.routes.draw do
  get "comments/new"

  get "comments/create"

  captcha_route

  resources :dynamic_statuses, only: [:new, :create, :index, :show] do
    resources :comments, only: [:new, :create]
  end
  resources :feeds do
    resources :comments, only: [:new, :create]
  end

  match 'photos/create' => 'photos#create'
  match 'home/about' => 'home#about'
  match 'group_groupships/accept' => 'group_groupships#accept'
  match 'group_invitationships/accept' => 'group_invitationships#accept'
  match 'private_messages/change_status' => 'private_messages#change_status'
  resources :private_messages, only: [:show, :create, :new]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :photos, only: [:show, :create, :update, :destroy] do
    resources :comments, only: [:new, :create]
  end

  resources :albums, only: [:show, :new, :edit, :create, :update, :destroy]

  resources :invitations, only: [:new, :create, :destroy, :show] do
    resources :comments, only: [:new, :create]
    member do
      post :fast_create
      get :applied_groups
    end
  end
  resources :groups, only: [:new, :show, :create, :update, :destroy, :edit, :index] do
    resources :comments, only: [:new, :create]
    member do
      post :add_members
      get :invite_posts, :sended_posts
    end
  end
  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }do
    get "logout" => "devise/sessions#destroy"
  end
#  devise_for :users
  resources :users do
    resource :profiles, only: [:update, :show, :edit]

    member do 
      get :following, :followers, :friends, 
          :groups, :following_invitations, :my_invitations,
          :received_invitations, :albums, :pending_requests,
          :my_private_messages, :visitors, :sended_requests,
          :latest_followers, :active_invitations, :participate_activities,
          :friends_invitations, :feeds, :status
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :group_groupships, only: [:create, :destroy, :show] do
    resources :comments, only: [:new, :create]
  end
  resources :group_invitationships, only: [:create, :destroy, :show] do
    resources :comments, only: [:new, :create]
  end

  match ':controller(/:action(/:id))'
end
