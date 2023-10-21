# frozen_string_literal: true

class TransactionFactory
  def call(args)
    case args[:transaction_type].downcase
    when 'authorize'
      TransactionTypes::AuthorizeService.new(args)
    when 'charge'
      TransactionTypes::ChargeService.new(args)
    when 'refund'
      TransactionTypes::RefundService.new(args)
    when 'reversal'
      TransactionTypes::ReversalService.new(args)
    end
  end
end
