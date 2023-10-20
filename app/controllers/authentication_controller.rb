# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    result = auth_service.login(email: params[:email], password: params[:password],
                                user_type: params[:user_type])
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
