# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionTypes::BaseService do
  describe '#index' do
    include_context 'charge transaction record'

    context 'without pagination' do
      it 'return all transactions' do
        result = described_class.new.index
        expect(result).to be_successful
        expect(result.attributes[:num_of_pages]).to eq 1
        expect(result.attributes[:transactions]).to match_array([authorize_transaction, charge_transaction])
      end
      it 'return an empty array' do
        Transaction.delete_all
        result = described_class.new.index
        expect(result).to be_successful
        expect(result.attributes[:num_of_pages]).to eq 1
        expect(result.attributes[:transactions]).to eq []
      end
    end
    context 'with pagination' do
      let(:subject) { described_class.new(args) }

      context 'with limit and page params' do
        let(:args) { { page: 2, limit: 1 } }

        it 'return the second page' do
          result = subject.index
          expect(result).to be_successful
          expect(result.attributes[:num_of_pages]).to eq 2
          expect(result.attributes[:transactions]).to eq [charge_transaction]
        end
      end
      context 'page param only' do
        let(:args) { { page: 1 } }

        it 'return all elements in first page' do
          result = subject.index
          expect(result).to be_successful
          expect(result.attributes[:num_of_pages]).to eq 1
          expect(result.attributes[:transactions]).to match_array([authorize_transaction, charge_transaction])
        end
      end
    end
  end
end
