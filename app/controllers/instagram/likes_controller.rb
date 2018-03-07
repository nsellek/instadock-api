class Instagram::LikesController < ApplicationController
  before_action :get_user

  def index
    media_id = params[:media_id]

    likes = INSTAGRAM.likes(token, media_id)

    render json: likes, status: 200
  end

  def create
    media_id = params[:media_id]

    like = INSTAGRAM.like(token, media_id)

    render json: like, status: 200
  end

  def destroy
    media_id = params[:id]

    like = INSTAGRAM.remove_like(token, media_id)

    render json: like, status: 200
  end
end
