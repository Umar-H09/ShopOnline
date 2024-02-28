Rails.application.routes.draw do
  devise_for :users, controllers: {
          sessions: 'users/sessions',
          registrations: 'users/registrations'
        }
  namespace :vendors do
    get 'home/index'
  end
  get '/admin', to: 'admins#index'
  resources :products
  resources :vendors
  root 'home#index'
  resources :orders
  post "/add_orderables", to: 'orders#add'
  post "/remove_orderables", to: 'orders#remove'
  get '/vendorproduct/:id', to: 'vendors#show_product', as: 'vendorproduct'
end
