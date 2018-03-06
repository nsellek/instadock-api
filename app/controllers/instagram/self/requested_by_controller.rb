class Instagram::Self::RequestedByController < ApplicationController
  before_action :get_user

  def index
    requests = INSTAGRAM.relationships(token)

    render json: requests, status: 200
  end
end