class User < ActiveRecord::Base
  has_many :logs
  has_many :meals

  has_secure_password
  validates :email, presence: { message: "Please enter email address" }
  validates :password, presence: { message: "Please enter password" }

end
