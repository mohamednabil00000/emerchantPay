# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_form_params)
    if @form.submit
      session[:auth_token] = auth_token
      # TO-DO redirect to page of transactions
    else
      flash[:notice] = I18n.t('errors.messages.wrong_email_or_password')
      redirect_to action: 'new'
    end
  end

  private

  def login_form_params
    params.require(:login_form).permit(:email, :password, :user_type)
  end
end
