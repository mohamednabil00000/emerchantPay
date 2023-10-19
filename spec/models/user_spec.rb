# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user, email: 'test@gmail.com') }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to validate_presence_of :password }
    it { should validate_inclusion_of(:status).in_array(%i[active inactive]) }
    it { should validate_inclusion_of(:role).in_array(%i[admin merchant]) }
    it { should_not allow_value('test@test').for(:email).with_message('invalid format') }
    it { should allow_value('user@example.com').for(:email) }
    it { is_expected.to validate_presence_of :password }
    it { should validate_confirmation_of(:password) }
    it {
      is_expected.to validate_length_of(:password).is_at_least(8)
                                                  .with_message('should be more than 7 chars')
    }
    it {
      is_expected.to validate_length_of(:password).is_at_most(16)
                                                  .with_message('should be less than 17 chars')
    }
  end

  describe 'scopes' do
    describe '#active' do
      let!(:user1) { create(:user, status: :active, email: 'email1@gmail.com') }
      let!(:user2) { create(:user, status: :active, email: 'email2@gmail.com') }
      let!(:user3) { create(:user, status: :inactive, email: 'email3@gmail.com') }

      it 'return active users' do
        expect(described_class.active).to match_array([user1, user2])
      end
    end
  end
end
