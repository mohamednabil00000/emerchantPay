# frozen_string_literal: true

class AuthService
  include JsonWebToken

  def login(email:, password:, user_type:)
    user = user_factory.login(user_type, email, password)
    if user
      token = jwt_encode(user_id: user.id)
      return ResultSuccess.new({ user:, token: })
    end

    ResultError.new({ error: I18n.t('errors.messages.unauthorized') })
  end

  private

  def user_factory
    @user_factory ||= UserFactory.new
  end
end
