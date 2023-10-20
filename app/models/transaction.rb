# frozen_string_literal: true

class Transaction < ApplicationRecord
  include EmailValidatable

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
