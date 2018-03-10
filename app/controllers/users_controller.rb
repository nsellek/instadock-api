class UsersController < ApplicationController
  skip_before_action :authorize_app
  before_action :authorize_user_creation

  def create
    user = User.new(@user_info)

    if user.save!
      payload = {
          app_key: params['api_key'],
          app_secret: ENV['APP_SECRET'],
          username: user.username,
          password_digest: user.password_digest
      }
      token = JwtToken.encode payload
      JwtToken.find_or_create_by!(jwt_token: token, user_id: user.id)

      render json: { jwt: token } , status: 200
    end
  end
end
