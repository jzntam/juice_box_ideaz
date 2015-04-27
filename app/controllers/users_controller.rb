class UsersController < ApplicationController
  # layout "user"

  def new
    @user = User.new
    @login_page = true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to ideas_path, notice: "Successfully Registered"
    else
      flash[:alert] = "Error creating account, please try again."
      # redirect_to new_user_path
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Updated Successfully! Good job!"
    else
      flash[:notice] = "Guess again..."
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :bio, :github, :twitter, :facebook)
  end

end
