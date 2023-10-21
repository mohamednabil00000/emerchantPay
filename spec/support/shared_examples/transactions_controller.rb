# frozen_string_literal: true

RSpec.shared_examples 'create transaction controller' do
  describe 'create transaction' do
    context '#success' do
      it 'when the transaction created successfully' do
        expect do
          post_request(path: :create, params:, token: auth_token)
          expect(response).to have_http_status(:created)
        end.to change { transaction_type.count }.by(1)
      end
    end
    context '#failure' do
      it 'when the transaction is already exist' do
        transaction = create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant.id,
                                                     status: :approved)
        params['transaction']['uuid'] = transaction.uuid
        expect do
          post_request(path: :create, params:, token: auth_token)
          expect(response).to have_http_status(:bad_request)
        end.not_to(change { transaction_type.count })
      end
    end
  end
end
