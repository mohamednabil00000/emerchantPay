# frozen_string_literal: true

class TransactionPresenter
  def self.transaction(transaction:)
    {
      id: transaction&.id,
      uuid: transaction&.uuid,
      transaction_type: transaction&.type,
      status: transaction.status,
      customer_email: transaction.parent.email,
      customer_phone: transaction.parent.phone_number,
      amount: transaction.parent.amount,
      parent_uuid: transaction.parent.uuid,
      merchant_id: transaction.parent.merchant_id
    }
  end
end
