# frozen_string_literal: true

class CustomerTransaction < ApplicationRecord
  include EmailValidatable

  has_many :customer_transaction_types, foreign_key: 'parent_id', primary_key: 'uuid', dependent: :destroy
  belongs_to :merchant

  validates :uuid, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
