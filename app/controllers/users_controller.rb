class UsersController < ApplicationController

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
      render "new"
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
