class InvitationMailer < ApplicationMailer

  def invite_user(invite)
    @receiving_email = invite.email
    @team_to_join = invite.team.title
    @invited_by = invite.user.full_name
    @invitation = invite

    mail(to: invite.email, subject: "You've Been Invited!")
  end

  # def notify_question_owner(answer)
  #   @answer = answer
  #   @question = answer.question
  #   @user = @question.user
  #   mail(to: @user.email, subject: "You got an answer!")
  # end

end
