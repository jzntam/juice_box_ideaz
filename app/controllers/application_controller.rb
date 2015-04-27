class ApplicationController < ActionController::Base
  before_action :store_in_session
  before_action :create_membership

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_session_path, alert: "Please sign in"
    end
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in? #makes it accessible in the views, not just controller

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user #makes it accessible in the views, not just

  def store_in_session
    if params[:invite].present?
      session[:invite] = params[:invite]
    end
  end

  def create_membership
    if session[:invite].present? && session[:user_id].present?

      invite = Invitation.find(session[:invite])
      membership = current_user.memberships.new
      membership.team = invite.team
      membership.member = true
      if membership.save
        flash[:notice] = "You've joined #{membership.team.title}!"
        @invite = Invitation.find(session[:invite])
        session.delete(:invite)
        redirect_to team_path(@invite.team)
      end
    end
  end
end
