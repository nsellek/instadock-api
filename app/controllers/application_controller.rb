class ApplicationController < ActionController::API
  before_action :authorize_app

  def authorize_app
    render json: {code: 400, error: 'JWT required'} && return unless params[:jwt].present?

    decoded_token = JwtToken.decode(params[:jwt])

    render json: {code: 401, error: 'Invalid token'} unless decoded_token[0]['app_secret'] == ENV['APP_SECRET']
  end
end
