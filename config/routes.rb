Rails.application.routes.draw do
  root to: "home#index"

  get '/courses/search', to: 'courses#index'

  resources :courses, only: [:show] do
    resources :scorecards, only: [:new, :create, :show] do
      resources :hole_scores, only: [:new, :create]
    end
  end

end
