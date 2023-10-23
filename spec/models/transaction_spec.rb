# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should_not allow_value('test@test').for(:email).with_message('invalid format') }
    it { should allow_value('user@example.com').for(:email) }
    it { is_expected.to validate_presence_of :uuid }
    it { should validate_inclusion_of(:status).in_array(%i[approved reversed refunded error]) }
    it do
      merchant = create(:merchant, email: 'test2@gmail.com')
      create(:authorize_transaction, email: 'test@gmail.com', merchant_id: merchant.id)
      is_expected.to validate_uniqueness_of(:uuid).ignoring_case_sensitivity
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:merchant) }
  end

  describe 'scopes' do
    include_context 'charge transaction record'
    describe '#sort_by_created_at' do
      it 'charge should be before authorize' do
        charge_transaction.update!(created_at: 1.day.ago)
        transaction = described_class.sort_by_created_at
        expect(transaction).to eq [charge_transaction, authorize_transaction]
      end
    end
  end

  describe '#approved?' do
    include_context 'authorize transaction record'

    let(:authorize_transaction2) do
      create(:authorize_transaction, email: 'test2@gmail.com', merchant_id: merchant.id, status: :error)
    end

    it 'returns true' do
      expect(authorize_transaction.approved?).to be_truthy
    end

    it 'returns false' do
      expect(authorize_transaction2.approved?).to be_falsy
    end
  end

  describe 'instance methods' do
    include_context 'authorize transaction record'

    describe '#convert_to_refunded!' do
      it 'when status converted to refunded' do
        authorize_transaction.convert_to_refunded!
        expect(authorize_transaction.status).to eq 'refunded'
      end
    end

    describe '#convert_to_reversed!' do
      it 'when status converted to reversed' do
        authorize_transaction.convert_to_reversed!
        expect(authorize_transaction.status).to eq 'reversed'
      end
    end
  end
end
