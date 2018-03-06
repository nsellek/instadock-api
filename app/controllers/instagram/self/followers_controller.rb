class Instagram::Self::FollowersController < ApplicationController
  before_action :get_user

  def index
    follows = INSTAGRAM.my_follows(token)

    render json: follows, status: 200
  end
end