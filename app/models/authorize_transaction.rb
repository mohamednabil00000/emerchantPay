# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
