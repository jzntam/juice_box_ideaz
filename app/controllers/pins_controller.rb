class PinsController < ApplicationController

  before_action :authenticate_user!

  def index
    @pins = current_user.pins.sort_by('postion')
  end

  def create
    idea = Idea.find params[:idea_id]
    pin = current_user.pins.new
    pin.idea = idea
    if pin.save
      redirect_to ideas_path, notice: "Pinned!"
    else
      redirect_to ideas_path, alert: "Pin not working, try again!"
    end
  end

  def destroy
    pin = current_user.pins.find params[:id]
    pin.destroy
    redirect_to ideas_path, alert: "Unpinned :("
  end

  def sort
    params[:pin].each_with_index do |id, index|
      Pin.find(id).update!(postion: index + 1)
    end
    render nothing: true
  end


end
