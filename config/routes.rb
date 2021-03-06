Rails.application.routes.draw do
  get 'users/profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'users', only: [:create] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:create, :edit, :update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'

  resources :user_profile
  resources :valuations
  resources :goals
  resources :asslibs

  root 'dashboard#index'
end
