# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionTypes::AuthorizeService do
  let!(:merchant) { create(:merchant, email: 'test2@gmail.com') }
  let(:subject) { described_class.new(args) }
  let(:args) do
    {
      uuid: '28f43c84-599b-4997-be0e-b1aa0d68703e',
      transaction_type: 'authorize',
      customer_email: 'test@gmail.com',
      customer_phone: '123434',
      status: 'approved',
      amount: 20,
      merchant_id: merchant.id
    }
  end

  it_behaves_like 'create transaction service' do
    let(:transaction) { AuthorizeTransaction }
  end
end
