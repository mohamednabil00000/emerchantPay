# frozen_string_literal: true

class TransactionTypeFactory
  def call(args)
    case args[:transaction_type]
    when 'Authorize'
      TransactionType::AuthorizeService.new(args)
    when 'Charge'
      TransactionType::ChargeService.new(args)
    when 'Refund'
      TransactionType::RefundService.new(args)
    when 'Reversal'
      TransactionType::ReversalService.new(args)
    end
  end
end
