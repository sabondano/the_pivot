Rails.application.routes.draw do
  root to: "static_pages#index"

  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :addresses, only: [:new, :update, :create]
  resources :categories, param: :slug, only: [:index,:show]
  resources :auctions, only: [:index, :show]
  resources :bids, only: [:index,:show,:new,:create,:edit,:update]
  resources :addresses, only: [:new,:create,:edit,:update]


  get :sellers, to: "sellers#index"

  scope :sellers, path: ':seller', as: :seller do
    get ':seller', to: "sellers#show"
  end


  get "/profile",    to: "users#show"
  get "/my-bids",   to: "users#feed"
  patch "/profile",    to: "users#update"
  post "/profile",     to: "users#create"
  get "/profile/new",  to: "users#new"
  get "/profile/edit", to: "users#edit"

  get "/login",        to: "sessions#new"
  post "/login",       to: "sessions#create"
  delete "/logout",    to: "sessions#destroy"

  namespace :super_admin do
    resources :products
    resources :users
    resources :seller
    resources :orders, only: [:index, :show, :update]

    get "/",           to: "admins#index"
    get "/dashboard",  to: "admins#index"
  end

  namespace :seller, path: ':seller', as: :seller do
    get '/', to: 'products#index'
    resources :auctions, only: [:index, :show]
    resources :categories, param: :slug, only: [:show]
    resources :products
    get "/dashboard",  to: "sellers#index"
  end

  resources :charges

  post "twilio/connect_customer" => "twilio#connect_customer"
end
