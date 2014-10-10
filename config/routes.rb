Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'dashboard', to: 'dashboard#index'
  root to: 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :content_entities, path: 'contentEntities' # TODO default path possible with ember?
<<<<<<< HEAD
      resources :links, only: [:index, :show]
      resources :notes, only: :index
      resources :users
      resources :groups do
        member do
          get :other_users
          get :members
        end
      end
=======
      resources :links, only: [:index, :show] do
        resources :comments
      end
      resources :notes, only: :index do
        resources :comments
      end
      resources :comments
>>>>>>> 4f8362b5e4ce2d46db4e1e659eb622f05eae97d2
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
