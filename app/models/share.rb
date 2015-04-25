class Share < ActiveRecord::Base
  validates :idea_id, uniqueness: {scope: :team_id}
  belongs_to :idea
  belongs_to :team
end
