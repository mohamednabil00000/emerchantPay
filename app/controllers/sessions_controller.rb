# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  def new; end

  def create
    email, password, user_type =  login_params.values
    result = auth_service.login(email:, password:, user_type:)
    if result.successful?
      session[:auth_token] = result.attributes[:token]
      redirect_to '/transactions'
    else
      flash[:notice] = I18n.t('errors.messages.wrong_email_or_password')
      redirect_to '/'
    end
  end

  private

  def login_params
    params.permit(:email, :password, :user_type)
  end
end
