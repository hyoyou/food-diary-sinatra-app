class User < ActiveRecord::Base
  has_many :logs
  has_many :meals
  
end
