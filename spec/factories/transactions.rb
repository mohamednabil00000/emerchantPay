# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :authorize_transaction do
    uuid { SecureRandom.uuid }
    email { Faker::Internet.email }
    phone_number { '12345' }
    amount { 1 }
    type { 'AuthorizeTransaction' }
  end

  factory :charge_transaction do
    uuid { SecureRandom.uuid }
    email { Faker::Internet.email }
    phone_number { '12345' }
    amount { 1 }
    type { 'ChargeTransaction' }
  end

  factory :refund_transaction do
    uuid { SecureRandom.uuid }
    email { Faker::Internet.email }
    phone_number { '12345' }
    amount { 1 }
    type { 'RefundTransaction' }
  end
end
