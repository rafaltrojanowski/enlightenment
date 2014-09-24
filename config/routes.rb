Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :content_entities, only: [:create, :index]
  get 'dashboard', to: 'dashboard#index'
  root to: 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :content_entities, only: :index, path: 'contentEntities' # TODO default path possible with ember?
      resources :notes, only: :index
    end
  end

  devise_for :administrators
  namespace :admin do
    resources :administrators
    root to: 'dashboard#index'
  end

  resources :groups do
    member do
      post :update_users
      get :other_users
    end
  end
end
