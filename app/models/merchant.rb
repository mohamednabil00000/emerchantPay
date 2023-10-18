# frozen_string_literal: true

class Merchant < ApplicationRecord
  belongs_to :user

  scope :active, -> { includes(:user).where(user: { status: :active }) }
end
