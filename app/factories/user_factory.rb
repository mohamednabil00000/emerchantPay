# frozen_string_literal: true

class UserFactory
  def find(user_type, user_id)
    if user_type == 'admin'
      Admin.find_by(id: user_id)
    elsif user_type == 'merchant'
      Merchant.find_by(id: user_id)
    end
  end

  def create(user_type, user_hash)
    if user_type == 'admin'
      admin_service.create(user_hash.except('description'))
    elsif user_type == 'merchant'
      merchant_service.create(user_hash)
    end
  end

  def login(user_type, email, password)
    if user_type == 'admin'
      Admin.find_authenticated(email:, password:)
    elsif user_type == 'merchant'
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
