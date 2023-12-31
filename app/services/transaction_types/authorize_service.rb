# frozen_string_literal: true

module TransactionTypes
  class AuthorizeService < TransactionTypes::BaseService
    def create
      authorize_transaction = create_authorize_transaction
      return ResultError.new(errors: authorize_transaction.errors.full_messages) unless authorize_transaction.save

      ResultSuccess.new({ transaction: authorize_transaction })
    end

    private

    def create_authorize_transaction
      transaction_type = AuthorizeTransaction.new(
        uuid: args[:uuid],
        amount: args[:amount],
        email: args[:customer_email],
        phone_number: args[:customer_phone],
        merchant_id: args[:merchant_id]
      )
      transaction_type[:status] = args[:status] if args[:status].present?
      transaction_type
    end
  end
end
