# frozen_string_literal: true

class ChargeTransaction < Transaction
  after_save :increment_total_transaction_sum_for_merchant!, if: :approved?

  validates :amount, presence: true, numericality: { greater_than: 0 }

  private

  def increment_total_transaction_sum_for_merchant!
    merchant.total_transaction_sum += amount
    merchant.save
  end
end
