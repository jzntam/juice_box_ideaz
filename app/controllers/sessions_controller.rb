class SessionsController < ApplicationController

  def new
    @login_page = true
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to ideas_path, notice: "Logged in!"
    else
      flash[:alert] = "Incorrect Login Info! Have you Signed Up?"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out!"
  end

end
