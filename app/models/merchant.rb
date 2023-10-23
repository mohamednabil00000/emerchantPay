# frozen_string_literal: true

class Merchant < ApplicationRecord
  before_destroy :can_destroy?, prepend: true
  include Userable

  has_many :transactions, dependent: :destroy

  private

  def can_destroy?
    return true unless transactions.any?

    errors.add(:base, I18n.t('errors.messages.can_not_delete_merchant_has_transaction'))
    throw :abort
  end
end
