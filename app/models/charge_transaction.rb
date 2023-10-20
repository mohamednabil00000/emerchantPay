# frozen_string_literal: true

class ChargeTransaction < CustomerTransactionType
  after_save :increment_total_transaction_sum_for_merchant!, if: :approved?

  private

  def increment_total_transaction_sum_for_merchant!
    merchant.total_transaction_sum += parent.amount
    merchant.save
  end
end
