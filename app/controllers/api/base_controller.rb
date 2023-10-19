# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include JsonWebToken

    before_action :authenticate_request

    private

    def authenticate_request
      header = request.headers['Authorization']
      return head :unauthorized unless header

      header = header.split.last
      decoded = jwt_decode(header)
      @current_user = User.find_by(id: decoded[:user_id])
      head :unauthorized unless @current_user
    rescue JWT::ExpiredSignature, JWT::DecodeError
      head :unauthorized
    end
  end
end
