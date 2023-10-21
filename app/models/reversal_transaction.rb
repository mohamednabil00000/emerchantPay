# frozen_string_literal: true

class ReversalTransaction < Transaction
  after_save :convert_authorize_transaction_to_reversed!

  private

  def convert_authorize_transaction_to_reversed!
    authorize_transaction = AuthorizeTransaction.find_by_uuid(parent_uuid)
    authorize_transaction&.convert_to_reversed!
  end
end
