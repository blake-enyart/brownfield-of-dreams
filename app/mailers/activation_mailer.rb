class ActivationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.activation_mailer.activation.subject
  #
  def activation(user)
    @user = user

    mail(to: user.email,
         subject: "#{user.first_name} please activate your account.")
  end
end
