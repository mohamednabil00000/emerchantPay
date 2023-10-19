# frozen_string_literal: true

class UserService
  def create_user(user_hash)
    user = User.create(user_hash.except('description'))
    return unless user.save

    Merchant.create!(user_id: user.id, description: user_hash['description']) if merchant?(user_hash['role'])
  end

  private

  def merchant?(role)
    role == 'merchant'
  end
end
