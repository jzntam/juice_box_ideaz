class IdeasController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @my_ideas = current_user.ideas
    @shared_with_me = current_user.shared_ideas.select(:title, :id, :user_id).distinct
    # @ideas = current_user.pinned_ideas
    @pins = current_user.pins.order('postion')
  end

  def show
    @idea = Idea.find params[:id]
    @comment = Comment.new
    @share = Share.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def new
    @idea = Idea.new
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = current_user.ideas.find(params[:id])
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to idea_path(@idea), notice: "Idea updated!" }
        format.json { respond_with_bip(@idea) }
      else
        format.html { flash[:alert] = "Please fix errors"; render :edit }
        format.json { render :json => @idea.errors.full_messages, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea = current_user.ideas.find(params[:id])
    if @idea.destroy
      redirect_to ideas_path, notice: "Idea deleted succesfully!"
    else
      flash[:error] = "You cannot delete a idea you did not create"
      redirect_to idea_path(@idea)
    end
  end


  private

  def idea_params
    params.require(:idea).permit(:title,:description, { team_ids: [] })
  end
end
