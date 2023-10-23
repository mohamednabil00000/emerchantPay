# frozen_string_literal: true

class TransactionPresenter
  def self.transaction(transaction:)
    {
      id: transaction&.id,
      uuid: transaction&.uuid,
      transaction_type: transaction&.type,
      status: transaction&.status,
      customer_email: transaction&.email,
      customer_phone: transaction&.phone_number,
      amount: transaction&.amount,
      parent_uuid: transaction&.parent_uuid,
      merchant_id: transaction&.merchant_id,
      merchant_name: transaction&.merchant&.name,
      created_at: transaction.created_at
    }
  end

  def self.transactions(transactions:)
    transactions.map do |transaction|
      transaction(transaction:)
    end
  end
end
