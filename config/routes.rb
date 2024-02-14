Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  get '/categories', to: 'categories#index'
  get '/admin', to: 'admins#index'
  resources :products
  root 'home#index'
end
