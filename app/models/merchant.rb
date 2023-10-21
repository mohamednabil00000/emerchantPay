# frozen_string_literal: true

class Merchant < ApplicationRecord
  include Userable

  has_many :transactions, dependent: :destroy
end
