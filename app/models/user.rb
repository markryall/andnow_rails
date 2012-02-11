class User < ActiveRecord::Base
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :token, :presence => true
  validates :token, :uniqueness => true
end