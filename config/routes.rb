Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :instagram do
    # all get requests
    ## Media requests
    get :my_media, to: 'instagram#my_media'
    get :my_liked_media, to: 'instagram#my_liked_media'
    get :find_media, to: 'instagram#find_media'
    ## Follower requests
    get :my_follows, to: 'instagram#my_follows'
    get :my_followers, to: 'instagram#my_followers'
    ## Relationships requests
    get :my_requested, to: 'instagram#my_requested'
    ## Comments requests
    get :get_comments, to: 'instagram#get_comments'
    # all post requests
    post :authorize, to: 'instagram#authorize'
    ## Relationships requests
    post :relationship, to: 'instagram#relationship'
    ## Comments requests
    post :comment, to: 'instagram#comment'
    # all delete requests
  end

  post 'app/auth_token', to: 'authentication#get_jwt_token'
end
