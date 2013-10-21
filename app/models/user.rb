class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
