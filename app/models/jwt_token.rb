class JwtToken < ApplicationRecord
  belongs_to :user, required: false

  def self.encode(payload)
    JWT.encode payload, ENV['APP_SECRET'], 'HS256'
  end

  def self.decode(token)
    JWT.decode token, ENV['APP_SECRET'], 'HS256'
  end

  def self.decode_for_user(token)
    JWT.decode token, nil, false
  end
end