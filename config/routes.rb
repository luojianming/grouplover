Rails3BootstrapDeviseCancan::Application.routes.draw do

  captcha_route

  match 'photos/create' => 'photos#create'
  match 'private_messages/change_status' => 'private_messages#change_status'
  resources :private_messages, only: [:show, :create]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :photos, only: [:show, :create, :update, :destroy] do
    resources :photo_comments, only: [:new, :create]
  end

  resources :albums, only: [:show, :new, :edit, :create, :update, :destroy]

  resources :invitations, only: [:new, :create, :destroy]
  resources :groups, only: [:new, :create, :update, :destroy, :edit, :index] do
    member do
      post :add_members
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
          :friends_invitations
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :group_invitationships, only: [:create, :destroy]

  match ':controller(/:action(/:id))'
end
