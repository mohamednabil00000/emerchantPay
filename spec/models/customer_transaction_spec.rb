# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerTransaction, type: :model do
  describe 'validations' do
    it { should_not allow_value('test@test').for(:email).with_message('invalid format') }
    it { should allow_value('user@example.com').for(:email) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'associations' do
    it {
      is_expected.to have_many(:customer_transaction_types)
        .with_foreign_key(:parent_id).with_primary_key(:uuid)
        .dependent(:destroy)
    }
  end
end
