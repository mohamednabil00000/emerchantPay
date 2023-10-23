# frozen_string_literal: true

RSpec.shared_context 'authorize transaction record' do
  let!(:merchant) { create(:merchant, email: 'test2@gmail.com') }
  let!(:authorize_transaction) do
    create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant.id, status: :approved)
  end
end

RSpec.shared_context 'charge transaction record' do
  let!(:merchant) { create(:merchant, email: 'test2@gmail.com') }
  let!(:authorize_transaction) do
    create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant.id, status: :approved)
  end
  let!(:charge_transaction) do
    create(:charge_transaction, email: 'test@gmail.com', merchant_id: merchant.id, status: :approved,
                                parent_uuid: authorize_transaction.uuid)
  end
end

RSpec.shared_context 'authorize and charge transactions json' do
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

  let(:expected_charge_json) do
    {
      id: charge_transaction.id,
      uuid: charge_transaction.uuid,
      transaction_type: charge_transaction&.type,
      status: charge_transaction&.status,
      customer_email: charge_transaction&.email,
      customer_phone: charge_transaction&.phone_number,
      amount: charge_transaction&.amount,
      parent_uuid: charge_transaction&.parent_uuid,
      merchant_id: charge_transaction&.merchant_id,
      merchant_name: merchant.name,
      created_at: charge_transaction.created_at
    }
  end
end
