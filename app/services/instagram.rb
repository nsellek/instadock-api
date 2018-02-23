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
        'redirect_uri': ENV['redirect_url']
    }

    response = InstaRequest.post('oauth/access_token', params, 'x-www-form-urlencoded')
    JSON.parse(response.body)
  end
end