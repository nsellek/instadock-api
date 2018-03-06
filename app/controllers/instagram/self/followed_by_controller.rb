class Instagram::Self::FollowedByController < ApplicationController
  before_action :get_user

  def index
    followers = INSTAGRAM.my_followers(token)

    render json: followers, status: 200
  end
end