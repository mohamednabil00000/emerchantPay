# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # POST /auth/login
  def login
    result = auth_service.login(email: params[:email], password: params[:password])
    if result.successful?
      render json: AuthPresenter.login(user: result.attributes[:user], token: result.attributes[:token]), status: :ok
    else
      render json: result.attributes, status: :unauthorized
    end
  end

  private

  def auth_service
    @auth_service ||= AuthService.new
  end
end
