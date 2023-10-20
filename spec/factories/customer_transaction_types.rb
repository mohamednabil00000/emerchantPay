# frozen_string_literal: true

FactoryBot.define do
  factory :customer_transaction_type do
    type { 'AuthorizeTransaction' }
  end
end
