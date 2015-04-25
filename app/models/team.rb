class Team < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true
end
