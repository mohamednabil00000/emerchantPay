# frozen_string_literal: true

module TransactionType
  class ChargeService < TransactionType::BaseService
    def create
      @charge_transaction = create_charge_transaction

      return ResultError.new(errors: @charge_transaction.errors.full_messages) unless @charge_transaction.save

      ResultSuccess.new({ transaction: @charge_transaction })
    end

    private

    def create_charge_transaction
      transaction_type = ChargeTransaction.new(
        uuid: args[:uuid],
        parent_id: args[:parent_uuid]
      )
      transaction_type[:status] = args[:status] if args[:status].present?
      transaction_type
    end
  end
end
