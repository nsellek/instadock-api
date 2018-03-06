class InstagramController < ApplicationController

  def authorize
    # TODO Figure out how to handle multiple apps per user
    token = JwtToken.find_by(jwt_token: params['jwt'])
    user = token.user || User.find_or_initialize_by(instagram_code: params[:code])

    if user.new_record? || user.instagram_token.nil? || user.instagram_code != params['code']
      access_token = @@instagram.auth_token(params[:code])
      user.instagram_code = params[:code]
      user.instagram_token = access_token['access_token']
      user.username = access_token['user']['username']
      user.save!
    end

    token.update(user_id: user.id)

    render json: {code: 200, message: 'Authorized'}, status: 200
  end
end