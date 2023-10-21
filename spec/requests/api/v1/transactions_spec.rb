# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: %i[api controller] do
  let(:merchant) { create(:merchant, email: 'test2@gmail.com') }
  let(:inactive_merchant) { create(:merchant, email: 'test2@gmail.com', status: :inactive) }
  let(:admin) { create(:admin, email: 'test2@gmail.com') }
  let(:auth_token) { jwt_encode(user_id: merchant.id, user_type: 'merchant') }
  let(:admin_auth_token) { jwt_encode(user_id: admin.id, user_type: 'admin') }
  let(:inactive_merchant_auth_token) { jwt_encode(user_id: inactive_merchant.id, user_type: 'merchant') }

  describe '#create' do
    it 'when merchant is inactive' do
      post_request(path: :create, token: inactive_merchant_auth_token)
      expect(response).to have_http_status(:unauthorized)
      body = JSON.parse(response.body)
      expect(body['errors']).to match_array ['User should be active merchant']
    end

    it 'when user is not merchant' do
      post_request(path: :create, token: admin_auth_token)
      expect(response).to have_http_status(:unauthorized)
      body = JSON.parse(response.body)
      expect(body['errors']).to match_array ['User should be active merchant']
    end
    context 'create authorize transaction' do
      it_behaves_like 'create transaction controller' do
        let(:transaction_type) { AuthorizeTransaction }
        let(:params) do
          {
            'transaction' => {
              'uuid' => '28f43c84-599b-4997-be0e-b1aa0d68701e',
              'transaction_type' => 'Authorize',
              'amount' => 1,
              'customer_email' => 'test@gmail.com',
              'customer_phone' => '123434',
              'status' => 'approved',
              'merchant_id' => merchant.id
            }
          }
        end
      end
    end
    context 'create charge transaction' do
      it_behaves_like 'create transaction controller' do
        include_context 'authorize transaction record'
        let(:transaction_type) { ChargeTransaction }
        let(:params) do
          {
            'transaction' => {
              'uuid' => '28f43c84-599b-4997-be0e-b1aa0d68701e',
              'transaction_type' => 'Charge',
              'amount' => 1,
              'customer_email' => 'test@gmail.com',
              'customer_phone' => '123434',
              'status' => 'approved',
              'parent_uuid' => authorize_transaction.uuid,
              'merchant_id' => merchant.id
            }
          }
        end
      end
    end

    context 'create refund transaction' do
      it_behaves_like 'create transaction controller' do
        include_context 'charge transaction record'
        let(:transaction_type) { RefundTransaction }
        let(:params) do
          {
            'transaction' => {
              'uuid' => '28f43c84-599b-4997-be0e-b1aa0d68701e',
              'transaction_type' => 'refund',
              'amount' => 1,
              'customer_email' => 'test@gmail.com',
              'customer_phone' => '123434',
              'status' => 'approved',
              'parent_uuid' => authorize_transaction.uuid,
              'merchant_id' => merchant.id
            }
          }
        end
      end
    end
    context 'create reversal transaction' do
      it_behaves_like 'create transaction controller' do
        include_context 'authorize transaction record'
        let(:transaction_type) { ReversalTransaction }
        let(:params) do
          {
            'transaction' => {
              'uuid' => '28f43c84-599b-4997-be0e-b1aa0d68701e',
              'transaction_type' => 'reversal',
              'amount' => 1,
              'customer_email' => 'test@gmail.com',
              'customer_phone' => '123434',
              'status' => 'approved',
              'parent_uuid' => authorize_transaction.uuid,
              'merchant_id' => merchant.id
            }
          }
        end
      end
    end
  end
end
