# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionPresenter do
  describe '#transaction' do
    include_context 'authorize transaction record'
    include_context 'authorize and charge transactions json'

    context 'present transaction' do
      it 'returns transaction' do
        expect(described_class.transaction(transaction: authorize_transaction)).to eq expected_authorize_json
      end
    end

    context 'present transactions' do
      include_context 'charge transaction record'
      it 'returns transaction' do
        expect(described_class.transactions(transactions: Transaction.all)).to match_array([expected_authorize_json,
                                                                                            expected_charge_json])
      end
    end
  end
end
