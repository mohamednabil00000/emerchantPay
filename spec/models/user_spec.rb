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

  describe '#find_authenticated' do
    let(:user) { create(:user, email: 'test@test.com', password: '12345678', name: 'test') }
    let(:inactive_user) do
      create(:user, email: 'test2@test.com', password: '12345678', name: 'test2', status: :inactive)
    end

    context '#success' do
      it 'when user exists' do
        expect(described_class.find_authenticated(email: user.email, password: user.password)).to eq user
      end
    end

    context '#failure' do
      it 'when user is inactive' do
        expect(described_class.find_authenticated(email: inactive_user.email,
                                                  password: inactive_user.password)).to be_nil
      end

      it 'when the password is wrong' do
        expect(described_class.find_authenticated(email: user.email, password: '1234568')).to be_nil
      end

      it 'when the email does not exist before' do
        expect(described_class.find_authenticated(email: 'test@tes.com', password: '12345678')).to be_nil
      end
    end
  end
end
