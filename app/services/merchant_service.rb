# frozen_string_literal: true

class MerchantService
  def create(merchant_hash)
    Merchant.create(merchant_hash)
  end

  def index(page:)
    @merchants = Merchant.all.paginate(page:)
    ResultSuccess.new({ merchants: @merchants })
  end

  def update(merchant:, new_attrs:)
    return ResultSuccess.new if merchant.update(new_attrs)

    ResultError.new(errors: merchant.errors.full_messages)
  end

  def destroy(merchant:)
    return ResultSuccess.new if merchant.destroy

    ResultError.new(errors: merchant.errors.full_messages)
  end
end
