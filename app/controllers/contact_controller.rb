class ContactController < ApplicationController

  before_action :authenticate_user!

  def contact_us
  end

  def send_form
    FeedbackMailer.send_feedback(contact_form_params).deliver_now
    redirect_to root_path
  end

  private

  def contact_form_params
    params.permit(:name, :email, :message)
  end
end
