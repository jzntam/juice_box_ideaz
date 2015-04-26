class Idea < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :pins, dependent: :destroy
  has_many :users_who_pinned, through: :pins, source: :user

  has_many :shares, dependent: :destroy
  has_many :teams_shared_with, through: :shares, source: :team

end