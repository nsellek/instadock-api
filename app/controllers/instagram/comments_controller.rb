class Instagram::CommentsController < ApplicationController
  before_action :get_user

  def index
    media_id = params[:media_id]

    comments = INSTAGRAM.comments(token, media_id)

    render json: comments, status: 200
  end

  def create
    media_id = params[:media_id]
    comment = params[:comment]

    comment = INSTAGRAM.comment(token, media_id, comment)

    render json: comment, status: 201
  end

  def destroy
    media_id = params[:media_id]
    comment_id = params[:id]

    comment = INSTAGRAM.remove_comment(token, media_id, comment_id)

    render json: comment, status: 200
  end
end
