class User < ApplicationRecord
  has_many :jwt_tokens
end
