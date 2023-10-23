# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MerchantService do
  describe '#create' do
    let(:subject) { described_class.new }

    it_behaves_like 'create user' do
      let(:user_hash) do
        {
          'name' => 'dummy',
          'email' => 'dummy@gmail.com',
          'password' => '12345678',
          'password_confirmation' => '12345678',
          'status' => 'active',
          'description' => 'test'
        }
      end
      let(:admin_records_count) { 0 }
      let(:merchant_records_count) { 1 }
    end
  end
  describe '#index' do
    let!(:merchant1) { create(:merchant, email: 'test1@gmail.com') }
    let!(:merchant2) { create(:merchant, email: 'test2@gmail.com') }

    it 'renders a successful response' do
      result = subject.index(page: 1)
      expect(result).to be_successful
      expect(result.attributes[:merchants]).to match_array [merchant1, merchant2]
    end
  end

  describe '#update' do
    let!(:merchant) { create(:merchant, email: 'test1@gmail.com') }
    let(:new_attributes) do
      {
        name: 'User',
        email: 'test2@gmail.com',
        description: 'hello world'
      }
    end

    it 'updates merchant successfully' do
      result = subject.update(merchant:, new_attrs: new_attributes)

      expect(result).to be_successful
      merchant.reload
      expect(merchant.name).to eq new_attributes[:name]
      expect(merchant.email).to eq new_attributes[:email]
      expect(merchant.description).to eq new_attributes[:description]
    end

    it 'invalid email' do
      new_attributes[:email] = 'sdsds'
      result = subject.update(merchant:, new_attrs: new_attributes)
      expect(result).not_to be_successful
      expect(result.attributes[:errors]).to match_array ['Email invalid format']
    end
  end
  describe '#destroy' do
    context 'when merchant has no trasactions' do
      let!(:merchant) { create(:merchant, email: 'test1@gmail.com') }
      it 'destroyed successfully' do
        expect do
          result = subject.destroy(merchant:)
          expect(result).to be_successful
        end.to change(Merchant, :count).by(-1)
      end
    end

    context 'when merchant has transactions' do
      include_context 'charge transaction record'
      it 'merchant will not be destroyed' do
        expect do
          result = subject.destroy(merchant:)
          expect(result).not_to be_successful
        end.not_to change(Merchant, :count)
      end
    end
  end
end
