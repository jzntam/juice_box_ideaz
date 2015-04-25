class User < ActiveRecord::Base

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, length: { minimum: 6},  confirmation: true, on: :create

  has_many :ideas, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :teams

  has_many :pins, dependent: :destroy
  has_many :pinned_ideas, through: :pins, source: :idea  

end
