Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :users, only: [:show]

  resources :courses, only: [:show] do
    get 'search', on: :collection, to: 'courses#index'
    resources :scorecards, only: [:new, :create, :show] do
      resources :hole_scores, only: [:new, :create]
    end
  end

end
