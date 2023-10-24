# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: %i[api controller] do
  describe '#index' do
    include_context 'charge transaction record'
    let(:token) { jwt_encode(user_id: merchant.id, user_type: 'merchant') }

    before do
      append_auth_token_session(token:)
    end

    context 'for admin user' do
      it 'return all transactions' do
        get_request(path: :index)
        expect(assigns(:transactions)).to eq([authorize_transaction, charge_transaction])
      end
      it 'return an empty array' do
        Transaction.delete_all
        get_request(path: :index)
        expect(assigns(:transactions)).to eq []
      end
    end

    context 'for merchant user' do
      let(:merchant2) { create(:merchant, email: 'test3@gmail.com') }
      let(:token) { jwt_encode(user_id: merchant2.id, user_type: 'merchant') }
      let!(:authorize_transaction2) do
        create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant2.id, status: :approved)
      end

      it 'returns only records for this merchant' do
        get_request(path: :index)
        expect(Transaction.count).to eq 3
        expect(assigns(:transactions)).to match_array([authorize_transaction2])
      end
    end
  end
end
