# frozen_string_literal: true

class CustomerTransactionType < ApplicationRecord
  belongs_to :parent, class_name: :CustomerTransaction, foreign_key: 'parent_id', primary_key: 'uuid'

  enum statuses: %i[approved reversed refunded error]

  validates :status, inclusion: { in: statuses }
  validates :uuid, presence: true, uniqueness: true

  def approved?
    status == 'approved'
  end

  def merchant
    parent.merchant
  end
end
