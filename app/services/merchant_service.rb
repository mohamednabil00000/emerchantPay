# frozen_string_literal: true

class MerchantService
  def create(merchant_hash)
    Merchant.create(merchant_hash)
  end
end
