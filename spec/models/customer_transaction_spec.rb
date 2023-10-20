# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerTransaction, type: :model do
  describe 'validations' do
    it { should_not allow_value('test@test').for(:email).with_message('invalid format') }
    it { should allow_value('user@example.com').for(:email) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_presence_of :uuid }
    it do
      merchant = create(:merchant, email: 'test2@gmail.com')
      create(:customer_transaction, email: 'test@gmail.com', merchant_id: merchant.id)
      is_expected.to validate_uniqueness_of(:uuid).ignoring_case_sensitivity
    end
  end

  describe 'associations' do
    it {
      is_expected.to have_many(:customer_transaction_types)
        .with_foreign_key(:parent_id).with_primary_key(:uuid)
        .dependent(:destroy)
    }
    it { is_expected.to belong_to(:merchant) }
  end
end
