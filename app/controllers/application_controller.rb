# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :authorize

  protected

  def authorize
    unless session_valid?
      return render json: { errors: [I18n.t('errors.messages.unauthorized')] },
                    status: :unauthorized
    end

    result = auth_service.authenticate_request(auth_header: auth_token)
    unless result.successful?
      return render json: { errors: [I18n.t('errors.messages.unauthorized')] },
                    status: :unauthorized
    end

    @current_user = result.attributes[:current_user]
    @user_type = result.attributes[:user_type]
  end

  def session_valid?
    auth_token.present?
  end

  def auth_token
    session[:auth_token]
  end

  def auth_service
    @auth_service ||= AuthService.new
  end
end
