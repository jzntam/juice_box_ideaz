class TeamsController < ApplicationController
  def index
    @team = Team.all
  end

  def create
    @team = current_user.teams.new(team_params)
    if @team.save
      flash[:notice] = "Team Created Successfully!"
      redirect_to team_path(@team)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:title)
  end

end
