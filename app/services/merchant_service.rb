# frozen_string_literal: true

class MerchantService
  def create(merchant_hash)
    Merchant.create(merchant_hash)
  end

  def index(page: nil, limit: nil)
    @merchants = Merchant.all
    @page = page
    @limit = limit
    num_of_pages = 1

    if pagination?
      num_of_pages = pagination.num_of_pages
      @merchants = @merchants.limit(pagination.limit).offset(pagination.offset)
    end

    ResultSuccess.new({ merchants: @merchants, num_of_pages: })
  end

  def update(merchant:, new_attrs:)
    return ResultSuccess.new if merchant.update(new_attrs)

    ResultError.new(errors: merchant.errors.full_messages)
  end

  def destroy(merchant:)
    return ResultSuccess.new if merchant.destroy

    ResultError.new(errors: merchant.errors.full_messages)
  end

  private

  def pagination?
    @page.present?
  end

  def pagination
    @pagination ||= Pagination.new(count: @merchants.size, page: @page, limit: @limit)
  end
end
