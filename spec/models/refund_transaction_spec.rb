# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefundTransaction, type: :model do
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'callbacks' do
    include_context 'charge transaction record'

    describe '#decrement_total_transaction_sum_for_merchant!' do
      context 'when status is approved' do
        it 'merchant amount should be 0' do
          described_class.create!(email: 'test@gmail.com', uuid: '28f43c84-599b-4997-be0e-b1aa0d68703e',
                                  merchant_id: merchant.id, status: :approved,
                                  parent_uuid: authorize_transaction.uuid, amount: 1)
          merchant.reload
          expect(merchant.total_transaction_sum).to eq 0
        end
      end
      context 'when status is not approved' do
        it 'merchant amount should be 1' do
          described_class.create!(email: 'test@gmail.com', uuid: '28f43c84-599b-4997-be0e-b1aa0d68703e',
                                  merchant_id: merchant.id, status: :error,
                                  parent_uuid: authorize_transaction.uuid, amount: 1)
          merchant.reload
          expect(merchant.total_transaction_sum).to eq 1
        end
      end
    end
    describe '#convert_charge_transaction_to_refund!' do
      it 'status should be changed to refunded' do
        described_class.create!(email: 'test@gmail.com', uuid: '28f43c84-599b-4997-be0e-b1aa0d68703e',
                                merchant_id: merchant.id, status: :approved,
                                parent_uuid: authorize_transaction.uuid, amount: 1)

        charge_transaction.reload
        expect(charge_transaction.status).to eq 'refunded'
      end
    end
  end
end
