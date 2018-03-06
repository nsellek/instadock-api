class Instagram::Self::MediaController < ApplicationController
  before_action :get_user

  def index
    oldest_media = params['oldest_media']

    media = INSTAGRAM.my_recent_media(token, oldest_media)
    next_set = media['pagination']['next_max_id']
    data = media['data']
    filtered_media = {
        next_set: next_set,
        data: data
    }

    render json: filtered_media, status: 200
  end
end