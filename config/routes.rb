Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :instagram do
    resources :comments, only: [:index, :create, :destroy]
    resources :relationships, only: [:update]
    resources :media, only: [:show]
    resources :likes, only: [:index, :create, :destroy]
    resources :tags, only: [:index, :show]
    resources :self, only: [:index]
    namespace :self do
      resources :followers, only: [:index]
      resources :media, only:[:index]
      resources :liked_media, only: [:index]
      resources :followed_by, only: [:index]
      resources :requested_by, only: [:index]
    end
    post :authorize, to: 'instagram#authorize'
  end

  scope :app do
    resources :users, only: [:create]
    get 'user', to: 'users#show'
  end
end
