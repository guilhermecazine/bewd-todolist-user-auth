class User < ApplicationRecord
  has_secure_password
  has_many :sessions
  has_many :tasks
end
