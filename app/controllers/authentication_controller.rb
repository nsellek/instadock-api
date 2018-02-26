class AuthenticationController < ApplicationController
  skip_before_action :authorize_app

  def get_jwt_token
    if params['api_key'] == ENV['APP_KEY']
      payload = {
          app_key: params['api_key'],
          app_secret: ENV['APP_SECRET'],
          rand_string: gen_rand_string
      }

      token = JwtToken.encode payload
      JwtToken.find_or_create_by!(jwt_token: token)

      render json: {jwt: token }
    else
      render json: {code: 400, error: 'Invalid Key'}, status: 400
    end
  end

  private

  def gen_rand_string
    o = [('a'..'z'), ('A'..'Z'), (0...9)].map(&:to_a).flatten
    (0...10).map { o[rand(o.length)] }.join
  end
end