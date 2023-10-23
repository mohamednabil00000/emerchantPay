# frozen_string_literal: true

class AuthPresenter
  def self.login(user:, token:)
    {
      id: user&.id,
      name: user&.name,
      email: user&.email,
      status: user&.status,
      token:
    }
  end
end
