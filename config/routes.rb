Rails.application.routes.draw do
  devise_for :users
  resources :users, except: [:create]
  namespace :api do
    namespace :v1 do
      resources :contacts
    end
  end
end
