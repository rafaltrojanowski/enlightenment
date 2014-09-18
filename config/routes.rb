Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'welcome#index'

  devise_for :administrators
  namespace :admin do
    resources :administrators
    root to: 'dashboard#index'
  end

  resources :groups
end
