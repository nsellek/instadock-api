class ApplicationController < ActionController::API
  before_action :authorize_app

  INSTAGRAM = Instagram.new

  def authorize_app
    render json: {code: 400, error: 'JWT required'}, status: 400 && return unless params[:jwt].present?

    decoded_token = JwtToken.decode(params[:jwt])

    render json: {code: 401, error: 'Invalid token'}, status: 401 unless decoded_token[0]['app_secret'] == ENV['APP_SECRET']
  end

  def get_user
    @user = JwtToken.find_by(jwt_token: params['jwt']).user
  end
end
