class UsersController < ApplicationController
  skip_before_action :authorize_app
  before_action :authorize_user

  def create
    user = User.new(@user_info)

    if user.save!
      payload = {
          app_key: ENV['APP_KEY'],
          app_secret: ENV['APP_SECRET'],
          username: user.username,
          password_digest: user.password_digest
      }
      token = JwtToken.encode payload
      JwtToken.find_or_create_by!(jwt_token: token, user_id: user.id)

      render json: { jwt: token } , status: 200
    end
  end

  def show
    user_info = JwtToken.decode_for_user(params[:jwt])[0]
    user = User.find_by(username: user_info['username'])

    if user.authenticate(user_info['password'])
      token = user.jwt_token.jwt_token
      render json: {jwt: token }, status: 200
    else
      render json: {error: 'Invalid Username or Password'}, status: 401
    end
  end
end
