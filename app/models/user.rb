class User < ActiveRecord::Base
  has_many :logs
  has_many :meals

  has_secure_password
  validates_presence_of :email
  validates_presence_of :password

end
