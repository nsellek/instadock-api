class Instagram::TagsController < ApplicationController
  before_action :get_user

  def index
    query = params[:query]

    tags = INSTAGRAM.get_tags(token, query)

    render json: tags, status: 200
  end

  def show
    tag_name = params[:id]
    max_tag_id = params[:max_tag_id]

    media = INSTAGRAM.get_tagged_media(token, tag_name, max_tag_id)
    next_set = media['pagination']['max_tag_id']
    data = media['data']
    filtered_media = {
        next_set: next_set,
        data: data
    }

    render json: filtered_media, status: 200
  end
end