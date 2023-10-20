# frozen_string_literal: true

class AuthPresenter
  def self.login(user:, token:)
    {
      name: user&.name,
      email: user&.email,
      status: user&.status,
      token:
    }
  end
end
