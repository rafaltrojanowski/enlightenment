Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'dashboard', to: 'dashboard#index'
  root to: 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :content_entities, path: 'contentEntities' # TODO default path possible with ember?
      resources :links, only: [:index, :show] do
        resources :comments
      end
      resources :notes, only: :index do
        resources :comments
      end
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
