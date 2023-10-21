# frozen_string_literal: true

module TransactionTypes
  class ReversalService < TransactionTypes::BaseService
    def create
      @reversal_transaction = create_reversal_transaction

      return ResultError.new(errors: @reversal_transaction.errors.full_messages) unless @reversal_transaction.save

      ResultSuccess.new({ transaction: @reversal_transaction })
    end

    private

    def create_reversal_transaction
      transaction_type = ReversalTransaction.new(
        uuid: args[:uuid],
        email: args[:customer_email],
        phone_number: args[:customer_phone],
        merchant_id: args[:merchant_id],
        parent_uuid: args[:parent_uuid]
      )
      transaction_type[:status] = args[:status] if args[:status].present?
      transaction_type
    end
  end
end
