RedSteel::Application.routes.draw do
  require 'sidekiq/web'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :update, :show]

  authenticate :user, lambda{ |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  root to: 'home#index'
end
