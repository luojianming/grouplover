Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :photos


  resources :albums


  resources :invitations
  resources :groups
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
          :received_invitations, :albums
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :group_invitationships, only: [:create, :destroy]

  match ':controller(/:action(/:id))'
end
