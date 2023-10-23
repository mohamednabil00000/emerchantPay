# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionTypes::BaseService do
  describe '#index' do
    include_context 'charge transaction record'

    context 'for admin user' do
      it 'return all transactions' do
        result = described_class.new.index
        expect(result).to be_successful
        expect(result.attributes[:transactions]).to match_array([authorize_transaction, charge_transaction])
      end
      it 'return an empty array' do
        Transaction.delete_all
        result = described_class.new.index
        expect(result).to be_successful
        expect(result.attributes[:transactions]).to eq []
      end
    end

    context 'for merchant user' do
      let(:merchant2) { create(:merchant, email: 'test3@gmail.com') }
      let!(:authorize_transaction2) do
        create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant2.id, status: :approved)
      end

      it 'returns only records for this merchant' do
        result = described_class.new(user_type: 'merchant', page: 1, current_user: merchant2).index
        expect(result).to be_successful
        expect(result.attributes[:transactions]).to eq [authorize_transaction2]
      end
    end
  end
end
