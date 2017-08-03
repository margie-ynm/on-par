Rails.application.routes.draw do
  root to: "home#index"

  get '/courses/search', to: 'courses#index'
end
