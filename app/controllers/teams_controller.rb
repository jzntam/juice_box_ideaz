class TeamsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.new(team_params)
    if @team.save
      flash[:notice] = "Team Created Successfully!"
      redirect_to team_path(@team)
    end
  end

  def show
    @team = Team.find params[:id]
  end

  def edit
    @team = Team.find params[:id]
    @invitation = Invitation.new
  end

  def update
    @team = Team.find params[:id]
    if @team.update(team_params)
      redirect_to @team, notice: "Team Successfully Updated"
    else
      flash[:alert] = "Team Not Updated"
      render :edit
    end
  end

  def destroy
    @team = Team.find params[:id]
    @team.destroy
    redirect_to user_path(current_user.id), notice: "Team Successfully Deleted"
  end

  private

  def team_params
    params.require(:team).permit(:title)
  end

end
