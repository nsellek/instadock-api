class InstagramController < ApplicationController
  before_action :get_user, except: :authorize

  def authorize
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

  def my_media
    oldest_media = params['oldest_media']

    media = @@instagram.self_recent_media(@user.instagram_token, oldest_media)
    next_set = media['pagination']['next_max_id']
    data = media['data']
    filtered_media = {
        next_set: next_set,
        data: data
    }

    render json: filtered_media, status: 200
  end

  def my_liked_media
    oldest_liked = params['oldest_liked']

    liked_media = @@instagram.self_liked_media(@user.instagram_token, oldest_liked)
    next_set = liked_media['pagination']['next_max_id']
    data = liked_media['data']
    filtered_liked_media = {
        next_set: next_set,
        data: data
    }

    render json: filtered_liked_media, status: 200
  end

  def my_follows
    follows = @@instagram.self_follows(@user.instagram_token)

    render json: follows, status: 200
  end
end