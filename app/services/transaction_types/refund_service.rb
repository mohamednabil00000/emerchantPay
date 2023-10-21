# frozen_string_literal: true

module TransactionTypes
  class RefundService < TransactionTypes::BaseService
    def create
      @refund_transaction = create_refund_transaction

      return ResultError.new(errors: @refund_transaction.errors.full_messages) unless @refund_transaction.save

      ResultSuccess.new({ transaction: @refund_transaction })
    end

    private

    def create_refund_transaction
      transaction_type = RefundTransaction.new(
        uuid: args[:uuid],
        amount: args[:amount],
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
