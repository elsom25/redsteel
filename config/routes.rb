RedSteel::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' } # 'omniauth_callbacks'
  resources :users, only: [:index, :edit, :update, :show]

  root to: 'home#index'
end
