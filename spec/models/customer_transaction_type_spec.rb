# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerTransactionType, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:status).in_array(%i[approved reversed refunded error]) }
    it { is_expected.to validate_presence_of :uuid }
    it do
      merchant = create(:merchant, email: 'test2@gmail.com')
      customer_transaction = create(:customer_transaction, email: 'test@gmail.com', merchant_id: merchant.id)
      create(:customer_transaction_type, type: 'AuthorizeTransaction',
                                         parent_id: customer_transaction.uuid, status: :approved)

      is_expected.to validate_uniqueness_of(:uuid).ignoring_case_sensitivity
    end
  end

  describe 'associations' do
    it {
      is_expected.to belong_to(:parent).class_name(:CustomerTransaction)
                                       .with_foreign_key(:parent_id).with_primary_key(:uuid)
    }
  end
end
