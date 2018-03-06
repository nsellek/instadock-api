class Instagram::Self::LikedMediaController < ApplicationController
  before_action :get_user

  def index
    oldest_liked = params['oldest_liked']

    liked_media = INSTAGRAM.my_liked_media(token, oldest_liked)
    next_set = liked_media['pagination']['next_max_id']
    data = liked_media['data']
    filtered_liked_media = {
        next_set: next_set,
        data: data
    }

    render json: filtered_liked_media, status: 200
  end
end