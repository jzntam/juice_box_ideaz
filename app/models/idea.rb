class Idea < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :pins, dependent: :destroy
  has_many :users_who_pinned, through: :pins, source: :user

  has_many :shares, dependent: :destroy
  has_many :teams_shared_with, through: :shares, source: :team

  # This is the algorithm that will generate a integer value that you will sort on.
  def activity_score
    self.comments.where(created_at: 2.months.ago..Date.today).count + self.pins.count * 5
  end

  # this takes a block that
  def self.active_ideas
    all.sort_by(&:activity_score)
  end

end
