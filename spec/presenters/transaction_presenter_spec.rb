# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionPresenter do
  describe '#transaction' do
    include_context 'authorize transaction record'
    let(:expected_authorize_json) do
      {
        id: authorize_transaction.id,
        uuid: authorize_transaction.uuid,
        transaction_type: authorize_transaction&.type,
        status: authorize_transaction&.status,
        customer_email: authorize_transaction&.email,
        customer_phone: authorize_transaction&.phone_number,
        amount: authorize_transaction&.amount,
        parent_uuid: authorize_transaction&.parent_uuid,
        merchant_id: authorize_transaction&.merchant_id,
        merchant_name: merchant.name,
        created_at: authorize_transaction.created_at
      }
    end

    context 'present transaction' do
      it 'returns transaction' do
        expect(described_class.transaction(transaction: authorize_transaction)).to eq expected_authorize_json
      end
    end
  end
end
