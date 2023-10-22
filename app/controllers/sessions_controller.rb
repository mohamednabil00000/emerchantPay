# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  def new; end

  def create
    result = auth_service.login(email: params[:email], password: params[:password], user_type: params[:user_type])
    if result.successful?
      session[:auth_token] = result.attributes[:token]
      # TO-DO redirect to page of transactions
    else
      flash[:notice] = I18n.t('errors.messages.wrong_email_or_password')
      redirect_to action: 'new'
    end
  end
end
