Rails.application.routes.draw do
  root to: "devos#index"
  resources :devos, only: [:index, :show]

  namespace :api do
    resources :devos, only: [:index, :show]
  end
end
