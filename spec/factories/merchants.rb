# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    status { :active }
  end
end
