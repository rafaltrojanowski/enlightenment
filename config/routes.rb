Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  devise_scope :user do
    put 'api/v1/users/:id', to: 'registrations#update'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'dashboard', to: 'dashboard#index'
  root to: 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :content_entities, path: 'contentEntities' do
        get :inbox, on: :collection
      end
      resources :links, only: [:index, :show]
      resources :notes, only: :index
      resources :users
      resources :groups do
        member do
          get :other_users
          get :members
        end
      end
      resources :comments
    end
  end

  devise_for :administrators do
    get '/administrators/sign_out' => 'devise/sessions#destroy'
  end
  namespace :admin do
    resources :administrators
    root to: 'dashboard#index'
  end

  resources :users, only: [:edit, :update]
end
