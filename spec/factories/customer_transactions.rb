# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :customer_transaction do
    uuid { SecureRandom.uuid }
    email { Faker::Internet.email }
    phone_number { '12345' }
    amount { 1 }
  end
end
