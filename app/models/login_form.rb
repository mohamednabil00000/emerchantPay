# frozen_string_literal: true

class LoginForm
  include ActiveModel::Model
  attr_accessor :email, :password, :user_type

  validates :email, :password, :user_type, presence: true

  def submit
    result = auth_service.login(email:, password:, user_type:)
    result.successful?
  end

  private

  def auth_service
    @auth_service ||= AuthService.new
  end
end
