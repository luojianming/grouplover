Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users, :controllers => {
 #   :registrations => "registrations",
    :sessions => "users/sessions",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }do
    get "logout" => "devise/sessions#destroy"
  end
#  devise_for :users
  resources :users
end
