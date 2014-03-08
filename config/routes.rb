Foodfun::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users

  root to: 'home#index'
end
