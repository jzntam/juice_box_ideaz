class Membership < ActiveRecord::Base
  validates :user_id, uniqueness: {scope: :team_id}
  belongs_to :user
  belongs_to :team
end
