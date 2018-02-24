class AuthenticationController < ApplicationController
  skip_before_action :authorize_app

  def get_jwt_token
    payload = {
        api_key: params['api_key'],
        api_secret: ENV['API_SECRET'],
        rand_string: gen_rand_string
    }

    token = JwtToken.encode payload
    JwtToken.find_or_create_by!(jwt_token: token)

    render json: {jwt: token }
  end

  private

  def gen_rand_string
    o = [('a'..'z'), ('A'..'Z'), (0...9)].map(&:to_a).flatten
    (0...10).map { o[rand(o.length)] }.join
  end
end