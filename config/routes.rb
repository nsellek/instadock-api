Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :instagram do
    post :authorize, to: 'instagram#authorize'
    get :my_media, to: 'instagram#my_media'
    get :my_liked_media, to: 'instagram#my_liked_media'
    get :my_follows, to: 'instagram#my_follows'
  end

  post 'app/auth_token', to: 'authentication#get_jwt_token'
end
