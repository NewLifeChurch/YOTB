Rails.application.routes.draw do
  namespace :api do
    resources :devos, only: [:index, :show]
  end
end
