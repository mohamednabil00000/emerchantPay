# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: %i[api controller] do
  describe '#index' do
    include_context 'charge transaction record'
    include_context 'authorize and charge transactions json'
    let(:token) { jwt_encode(user_id: merchant.id, user_type: 'merchant') }

    before do
      append_auth_token_session(token:)
    end

    context 'without pagination' do
      it 'return all transactions' do
        get_request(path: :index)
        expect(assigns(:num_of_pages)).to eq 1
        expect(assigns(:transactions)).to eq([expected_authorize_json, expected_charge_json])
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
          expect(assigns(:transactions)).to eq [expected_charge_json]
        end
      end
      context 'page param only' do
        it 'return all elements in first page' do
          get_request(path: :index, params: { page: 1 })
          expect(assigns(:num_of_pages)).to eq 1
          expect(assigns(:transactions)).to eq([expected_authorize_json, expected_charge_json])
        end
      end
    end

    context 'create another merchant' do
      let(:merchant2) { create(:merchant, email: 'test3@gmail.com') }
      let(:token) { jwt_encode(user_id: merchant2.id, user_type: 'merchant') }
      let!(:authorize_transaction2) do
        create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant2.id, status: :approved)
      end

      let(:exp_element_response) do
        {
          id: authorize_transaction2.id,
          uuid: authorize_transaction2.uuid,
          transaction_type: authorize_transaction2.type,
          status: authorize_transaction2.status,
          customer_email: authorize_transaction2.email,
          customer_phone: authorize_transaction2.phone_number,
          amount: authorize_transaction2.amount,
          parent_uuid: authorize_transaction2.parent_uuid,
          merchant_id: merchant2.id,
          merchant_name: merchant2.name,
          created_at: authorize_transaction2.created_at
        }
      end

      it 'returns only records for this merchant' do
        get_request(path: :index)
        expect(Transaction.count).to eq 3
        expect(assigns(:num_of_pages)).to eq 1
        expect(assigns(:transactions)).to match_array([exp_element_response])
      end
    end
  end
end
