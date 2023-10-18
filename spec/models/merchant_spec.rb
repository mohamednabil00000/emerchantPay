# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'scopes' do
    describe '#active' do
      let!(:user1) { create(:user, status: :active, email: 'email1@gmail.com', role: :merchant) }
      let!(:user2) { create(:user, status: :active, email: 'email2@gmail.com', role: :merchant) }
      let!(:user3) { create(:user, status: :inactive, email: 'email3@gmail.com', role: :merchant) }
      let!(:merchant1) { create(:merchant, user: user1) }
      let!(:merchant2) { create(:merchant, user: user2) }
      let!(:merchant3) { create(:merchant, user: user3) }

      it 'return active merchants' do
        expect(described_class.active).to match_array([merchant1, merchant2])
      end
    end
  end
end
