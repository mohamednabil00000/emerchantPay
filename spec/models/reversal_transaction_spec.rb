# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReversalTransaction, type: :model do
  describe 'callbacks' do
    include_context 'authorize transaction record'

    describe '#convert_authorize_transaction_to_reversed!' do
      it 'status should be changed to refunded' do
        described_class.create!(email: 'test@gmail.com', uuid: '28f43c84-599b-4997-be0e-b1aa0d68703e',
                                merchant_id: merchant.id, status: :approved,
                                parent_uuid: authorize_transaction.uuid)

        authorize_transaction.reload
        expect(authorize_transaction.status).to eq 'reversed'
      end
    end
  end
end
