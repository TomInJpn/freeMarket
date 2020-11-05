Rails.application.routes.draw do

  devise_for :users,controllers:{registrations:'users/registrations',sessions:'users/sessions'}
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'

  # resources :items, only: [:index, :show, :new, :edit]

  # root "items#new"
  resources :items ,except: :index do
    collection do
      get 'get_children'
      get 'get_grand_children'
    end
    member do
      get 'purchase'
      get 'payment'
    end
  end
  resources :categories ,only: :new

  resources :card,only: [:new,:create,:destroy]

  get '/users/out', to: 'users#out'
  resources :users, only: [:show]

end
