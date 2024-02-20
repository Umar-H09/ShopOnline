Rails.application.routes.draw do
  namespace :vendors do
    get 'home/index'
  end
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  get '/categorys', to: 'categorys#index'
  get '/admin', to: 'admins#index'
  resources :products
  resources :vendors
  root 'home#index'
  resources :orders
  post "/add_orderables", to: 'orders#add'
  post "/remove_orderables", to: 'orders#remove'

end
