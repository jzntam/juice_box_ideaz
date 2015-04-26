class SharesController < ApplicationController

  def create
    idea = Idea.find(params[:idea_id])
    teams = params["share"]["team_ids"]

    if teams && teams.count > 1
      teams.each do |t|
        if t.present?
          Share.create(team_id: t, idea_id: idea.id )
        end
      end
    else
      error = "You must have atleast 1 team"
      redirect_to :back
    end

    if error.present?
      flash[:error] = "Sorry something went wrong"
    else
      flash[:notice] = "Created successfully"
      redirect_to idea_path(idea)
    end
  end
end
