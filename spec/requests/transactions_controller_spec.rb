# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: %i[api controller] do
  describe '#index' do
    include_context 'charge transaction record'
    let(:token) { jwt_encode(user_id: merchant.id, user_type: 'merchant') }

    before do
      append_auth_token_session(token:)
    end

    context 'without pagination' do
      it 'return all transactions' do
        get_request(path: :index)
        expect(assigns(:num_of_pages)).to eq 1
        expect(assigns(:transactions)).to eq([authorize_transaction, charge_transaction])
      end
      it 'return an empty array' do
        Transaction.delete_all
        get_request(path: :index)
        expect(assigns(:num_of_pages)).to eq 1
        expect(assigns(:transactions)).to eq []
      end
    end
    context 'with pagination' do
      context 'with limit and page params' do
        it 'return the second page' do
          get_request(path: :index, params: { page: 2, limit: 1 })
          expect(assigns(:num_of_pages)).to eq 2
          expect(assigns(:transactions)).to eq [charge_transaction]
        end
      end
      context 'page param only' do
        it 'return all elements in first page' do
          get_request(path: :index, params: { page: 1 })
          expect(assigns(:num_of_pages)).to eq 1
          expect(assigns(:transactions)).to eq([authorize_transaction, charge_transaction])
        end
      end
    end

    context 'create another merchant' do
      let(:merchant2) { create(:merchant, email: 'test3@gmail.com') }
      let(:token) { jwt_encode(user_id: merchant2.id, user_type: 'merchant') }
      let!(:authorize_transaction2) do
        create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant2.id, status: :approved)
      end

      it 'returns only records for this merchant' do
        get_request(path: :index)
        expect(Transaction.count).to eq 3
        expect(assigns(:num_of_pages)).to eq 1
        expect(assigns(:transactions)).to match_array([authorize_transaction2])
      end
    end
  end
end
