class Instagram::RelationshipsController < ApplicationController
  before_action :get_user

  def update
    action = params[:action]
    user_id = params[:id]

    relationship = INSTAGRAM.send_relationship(token, action, user_id)

    render json: relationship, status: 200
  end
end