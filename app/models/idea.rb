class Idea < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
end
