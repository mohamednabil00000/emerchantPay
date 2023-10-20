# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_request

  protect_from_forgery

  protected

  def authenticate_request
    result = auth_service.authenticate_request(auth_header: request.headers['Authorization'],
                                               user_type_header: request.headers['User-Type'])
    return head :unauthorized unless result.successful?

    @current_user = result.attributes[:current_user]
  end

  def auth_service
    @auth_service ||= AuthService.new
  end
end
