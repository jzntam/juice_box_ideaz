class PinsController < ApplicationController

  before_action :authenticate_user!

  def index
    @ideas = current_user.pinned_ideas
  end

  def create
    idea = Idea.find params[:idea_id]
    pin = current_user.pins.new
    pin.idea = idea
    if pin.save
      redirect_to idea, notice: "Pinned!"
    else
      redirect_to idea, alert: "Pin not working, try again!"
    end
  end

  def destroy
    pin = current_user.pins.find params[:id]
    pin.destroy
    redirect_to pin.idea, alert: "Unpinned :("
  end

end
