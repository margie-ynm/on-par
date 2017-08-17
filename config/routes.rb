Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :users, only: [:show] do
    resources :scorecards, only: [:show, :destroy]
  end

  resources :courses, only: [:show, :index] do
    get 'search', on: :collection, to: 'courses#index'
    resources :scorecards, only: [:new, :create] do
      resources :hole_scores, only: [:new, :create, :edit, :update]
    end
  end

end
