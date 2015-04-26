class CommentsController < ApplicationController
  # before_action :find_idea
  # before_action :find_comment

  def index
  end

  def create
    @idea         = Idea.find params[:idea_id]
    @comment      = Comment.new(comment_params)
    @comment.user = current_user
    @comment.idea = @idea
    respond_to do |format|
    if @comment.save
      format.html {redirect_to idea_path(@idea), 
                    notice: "comment created!" }
      format.js { render :create_success}
    else
      format.html {render "ideas/show"}
      format.js {render :create_failure}
    end
    end
  end

  def edit
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
  end

  def update
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
    if @comment.update comment_params
      redirect_to @idea, notice: "Comment successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to idea_path(@idea), 
                  notice: "comment deleted"
  end

  private

  # def find_idea
  #   @idea = Idea.find params[:idea_id]
  # end

  # def find_comment
  #   @comment = Comment.find params[:id]
  # end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
