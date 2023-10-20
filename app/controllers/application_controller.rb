# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JsonWebToken

  before_action :authenticate_request

  protect_from_forgery

  private

  def authenticate_request
    header = request.headers['Authorization']
    return head :unauthorized unless header

    header = header.split.last
    decoded = jwt_decode(header)
    @current_user = user_factory.find(request.headers['UserType'], decoded[:user_id])
    head :unauthorized unless @current_user
  rescue JWT::ExpiredSignature, JWT::DecodeError
    head :unauthorized
  end

  def user_factory
    @user_factory ||= UserFactory.new
  end
end
