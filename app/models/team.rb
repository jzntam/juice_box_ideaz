class Team < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :membered_users, through: :memberships, source: :user

  has_many :shares, dependent: :destroy
  has_many :shared_ideas, through: :shares, source: :idea
end
