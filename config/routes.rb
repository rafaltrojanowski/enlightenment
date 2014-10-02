Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'dashboard', to: 'dashboard#index'
  root to: 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :content_entities, path: 'contentEntities' # TODO default path possible with ember?
      resources :links, only: [:index, :show]
      resources :notes, only: :index
      resources :groups, only: [:index, :show]
    end
  end

  devise_for :administrators do
    get '/administrators/sign_out' => 'devise/sessions#destroy'
  end
  namespace :admin do
    resources :administrators
    root to: 'dashboard#index'
  end

  # resources :groups do
  #   member do
  #     post :update_users
  #     get :other_users
  #   end
  # end

  resources :users, only: [:edit, :update]
end
