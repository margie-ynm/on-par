Rails.application.routes.draw do
  root to: "home#index"

  resources :courses, only: [:show] do
    get 'search', on: :collection, to: 'courses#index'
    resources :scorecards, only: [:new, :create, :show] do
      resources :hole_scores, only: [:new, :create]
    end
  end

end
