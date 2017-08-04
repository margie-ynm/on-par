Rails.application.routes.draw do
  root to: "home#index"

  get '/courses/search', to: 'courses#index'
  get '/courses/:id', to: 'courses#show'
end
