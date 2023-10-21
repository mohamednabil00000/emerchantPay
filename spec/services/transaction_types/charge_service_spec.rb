# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionTypes::ChargeService do
  include_context 'authorize transaction record'

  let(:subject) { described_class.new(args) }
  let(:args) do
    {
      uuid: '28f43c84-599b-4997-be0e-b1aa0d68703e',
      transaction_type: 'charge',
      customer_email: 'test@gmail.com',
      customer_phone: '123434',
      status: 'approved',
      amount: 1,
      merchant_id: merchant.id,
      parent_uuid: authorize_transaction.uuid
    }
  end

  it_behaves_like 'create transaction service' do
    let(:transaction) { ChargeTransaction }
  end
end
