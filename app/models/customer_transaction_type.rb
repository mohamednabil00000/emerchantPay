# frozen_string_literal: true

class CustomerTransactionType < ApplicationRecord
  belongs_to :parent, class_name: :CustomerTransaction, foreign_key: 'parent_id', primary_key: 'uuid'

  enum statuses: %i[approved reversed refunded error]

  validates :status, inclusion: { in: statuses }
  validates_uniqueness_of :parent_id, scope: :type, message: I18n.t('errors.messages.record_already_exist')
end
