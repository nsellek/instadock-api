class Instagram

  def initialize
    @client_id = ENV['INSTA_CLIENT_ID']
    @client_secret = ENV['INSTA_CLIENT_SECRET']
  end

  def auth_token(auth_code)
    params = {
        'client_id': @client_id,
        'client_secret': @client_secret,
        'grant_type': 'authorization_code',
        'code': auth_code,
        'redirect_uri': ENV['REDIRECT_URL']
    }
    response = InstaRequest.post('oauth/access_token', params)
    json_parse(response)
  end

  # Media
  def my_recent_media(access_token, max_id=nil)
    params = {
        'access_token': access_token,
        'max_id': max_id,
        'count': '15'
    }

    response = InstaRequest.get('v1/users/self/media/recent', params)
    json_parse(response)
  end

  def my_liked_media(access_token, max_id=nil)
    params = {
        'access_token': access_token,
        'max_like_id': max_id,
        'count': '15'
    }

    response = InstaRequest.get('v1/users/self/media/liked', params)
    json_parse(response)
  end

  def find_media(access_token, media_id)
    params = {
        'access_token': access_token
    }

    media = InstaRequest.get("v1/media/#{media_id}", params)
    json_parse(media)
  end

  # Followers
  def my_follows(access_token)
    params = {
        'access_token': access_token
    }

    response = InstaRequest.get('v1/users/self/follows', params)
    json_parse(response)
  end

  def my_followers(access_token)
    params = {
        'access_token': access_token
    }

    response = InstaRequest.get('v1/users/self/followed-by', params)
    json_parse(response)
  end

  # relationships
  def my_requested(access_token)
    params = {
        'access_token': access_token
    }

    response = InstaRequest.get('v1/users/self/requested-by', params)
    json_parse(response)
  end

  def send_relationship(access_token, action, user_id)
    params = {
        'access_token': access_token,
        'action': action
    }

    response = InstaRequest.post("v1/users/#{user_id}/relationship", params)
    json_parse(response)
  end

  # Comments
  def get_comments(access_token, media_id)
    params = {
        'access_token': access_token
    }

    response = InstaRequest.get("v1/media/#{media_id}/comments", params)
    json_parse(response)
  end

  def comment(access_token, media_id, comment)
    params ={
        'access_token': access_token,
        'text': comment
    }

    response = InstaRequest.post("v1/media/#{media_id}/comments", params)
    json_parse(response)
  end

  private

  def json_parse(response)
    JSON.parse(response.body)
  end
end