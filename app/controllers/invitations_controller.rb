class InvitationsController < ApplicationController
  #before_action :generate_token

  def create

    email_chain = params[:invitation][:email]
    white_space_removed = email_chain.gsub(' ', '')
    email_array = white_space_removed.split(",")
    @team = Team.find(params[:team_id])

    #binding.pry

    email_array.each do |passed_email|
      @invitation = current_user.invitations.new(invitation_params)
      @invitation.email = passed_email
      @invitation.team = @team
      @invitation.user = current_user
      if @invitation.save
        InvitationMailer.invite_user(@invitation).deliver_now
      end
    end

    redirect_to @team

    # emails.each do
    #   send email to 'email', 'team' .actionmailermethod
    # end

  end

  private

  # def generate_token
  #    self.token = Digest::SHA1.hexdigest([self., Time.now, rand].join)
  # end

  def invitation_params
    params.require(:invitation).permit(:email, :token, :team_id)
  end

end
