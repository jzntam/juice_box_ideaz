class User < ActiveRecord::Base
  has_many :teams

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, length: { minimum: 6},  confirmation: true, on: :create
end
