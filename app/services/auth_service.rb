# frozen_string_literal: true

class AuthService
  include JsonWebToken

  def login(email:, password:)
    user = User.find_authenticated(email:, password:)
    if user
      token = jwt_encode(user_id: user.id)
      return ResultSuccess.new({ user:, token: })
    end

    ResultError.new({ error: I18n.t('errors.messages.unauthorized') })
  end
end
