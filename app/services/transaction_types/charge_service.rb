# frozen_string_literal: true

module TransactionTypes
  class ChargeService < TransactionTypes::BaseService
    def create
      @charge_transaction = create_charge_transaction

      return ResultError.new(errors: @charge_transaction.errors.full_messages) unless @charge_transaction.save

      ResultSuccess.new({ transaction: @charge_transaction })
    end

    private

    def create_charge_transaction
      transaction_type = ChargeTransaction.new(
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
