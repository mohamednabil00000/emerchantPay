# frozen_string_literal: true

class AuthService
  include JsonWebToken

  def login(email:, password:, user_type:)
    user = user_factory.login(user_type, email, password)
    return ResultError.new({ error: I18n.t('errors.messages.unauthorized') }) unless user

    token = jwt_encode(user_id: user.id, user_type:)
    ResultSuccess.new({ user:, token: })
  end

  def authenticate_request(auth_header:)
    return ResultError.new unless auth_header

    decoded = jwt_decode(auth_header.split.last)
    current_user = user_factory.find(decoded[:user_type], decoded[:user_id])
    return ResultError.new unless current_user

    ResultSuccess.new({ current_user:, user_type: decoded[:user_type] })
  rescue JWT::ExpiredSignature, JWT::DecodeError
    ResultError.new
  end

  private

  def user_factory
    @user_factory ||= UserFactory.new
  end
end
