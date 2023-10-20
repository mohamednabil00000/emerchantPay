# frozen_string_literal: true

class Merchant < ApplicationRecord
  include Userable

  has_many :customer_transactions, dependent: :destroy
end
