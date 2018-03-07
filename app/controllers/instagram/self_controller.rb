class Instagram::SelfController < ApplicationController
  before_action :get_user

  def index
    me = INSTAGRAM.get_me(token)

    render json: me['data'], status: 200
  end
end