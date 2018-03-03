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

  # Media
  def my_media
    oldest_media = params['oldest_media']

    media = INSTAGRAM.my_recent_media(@user.instagram_token, oldest_media)
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

    liked_media = INSTAGRAM.my_liked_media(@user.instagram_token, oldest_liked)
    next_set = liked_media['pagination']['next_max_id']
    data = liked_media['data']
    filtered_liked_media = {
        next_set: next_set,
        data: data
    }

    render json: filtered_liked_media, status: 200
  end

  def find_media
    media_id = params[:media_id]

    media = INSTAGRAM.find_media(@user.instagram_token, media_id)
    media = {
        media: media['data']
    }

    render json: media, status: 200
  end

  # Followers
  def my_follows
    follows = INSTAGRAM.my_follows(@user.instagram_token)

    render json: follows, status: 200
  end

  def my_followers
    followers = INSTAGRAM.my_followers(@user.instagram_token)

    render json: followers, status: 200
  end

  # Relationships
  def my_requested
    requests = INSTAGRAM.my_requested(@user.instagram_token)

    render json: requests, status: 200
  end

  def relationship
    action = params[:action]
    user_id = params[:user_id]

    relationship = INSTAGRAM.send_relationship(@user.instagram_token, action, user_id)

    render json: relationship, status: 200
  end

  # Comments
  def get_comments
    media_id = params[:media_id]

    comments = INSTAGRAM.get_comments(@user.instagram_token, media_id)

    render json: comments, status: 200
  end
end