class ApplicationController < ActionController::API
  before_action :authorize_app

  INSTAGRAM = Instagram.new

  private

  def authorize_app
    unless params[:jwt].present?
      render json: {code: 400, error: 'JWT required'}, status: 400
      return false
    end

    decoded_token = JwtToken.decode(params[:jwt])

    unless decoded_token[0]['app_secret'] == ENV['APP_SECRET']
      render json: {code: 401, error: 'Invalid token'}, status: 401
      return false
    end
  end

  def get_user
    @user = JwtToken.find_by(jwt_token: params['jwt']).user
  end

  def token
    @user.instagram_token
  end
end
