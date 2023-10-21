# frozen_string_literal: true

class RefundTransaction < Transaction
  after_save :convert_charge_transaction_to_refund!
  after_save :decrement_total_transaction_sum_for_merchant!, if: :approved?

  validates :amount, presence: true, numericality: { greater_than: 0 }

  private

  def decrement_total_transaction_sum_for_merchant!
    merchant.total_transaction_sum -= amount
    merchant.save
  end

  def convert_charge_transaction_to_refund!
    charge_transaction = ChargeTransaction.find_by_parent_uuid(parent_uuid)
    charge_transaction&.convert_to_refunded!
  end
end
