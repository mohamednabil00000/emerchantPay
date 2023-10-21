# frozen_string_literal: true

class UserFactory
  def find(user_type, user_id)
    case user_type.downcase
    when 'admin'
      Admin.find_by(id: user_id)
    when 'merchant'
      Merchant.find_by(id: user_id)
    end
  end

  def create(user_type, user_hash)
    case user_type.downcase
    when 'admin'
      admin_service.create(user_hash.except('description'))
    when 'merchant'
      merchant_service.create(user_hash)
    end
  end

  def login(user_type, email, password)
    case user_type.downcase
    when 'admin'
      Admin.find_authenticated(email:, password:)
    when 'merchant'
      Merchant.find_authenticated(email:, password:)
    end
  end

  private

  def admin_service
    @admin_service ||= AdminService.new
  end

  def merchant_service
    @merchant_service ||= MerchantService.new
  end
end
