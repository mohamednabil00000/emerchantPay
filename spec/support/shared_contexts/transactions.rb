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

RSpec.shared_context 'charge transaction record from one hour ago' do
  let!(:merchant) { create(:merchant, email: 'test2@gmail.com') }
  let!(:authorize_transaction) do
    create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant.id, status: :approved,
                                   created_at: 58.minutes.ago)
  end
  let!(:charge_transaction) do
    create(:charge_transaction, email: 'test@gmail.com', merchant_id: merchant.id, status: :approved,
                                parent_uuid: authorize_transaction.uuid, created_at: 1.hour.ago)
  end
end
