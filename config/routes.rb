Rails.application.routes.draw do
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/about',   to: 'home#index'
  get '/contact', to: 'home#index'
  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update,:destroy]
  end

end
