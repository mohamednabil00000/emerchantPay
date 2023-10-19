# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthService do
  describe '#login' do
    let(:subject) { described_class.new }
    let(:user) { create(:user, email: 'test@test.com', password: '12345678', name: 'test') }
    let(:inactive_user) do
      create(:user, email: 'test2@test.com', password: '12345678', name: 'test2', status: :inactive)
    end

    context '#success' do
      it 'when login successfully' do
        result = subject.login(email: user.email, password: user.password)
        expect(result).to be_successful
        expect(result.attributes.keys).to match_array(%i[user token])
        expect(result.attributes[:user]).to eq user
      end
    end

    context '#failure' do
      it 'when user is inactive' do
        result = subject.login(email: inactive_user.email, password: inactive_user.password)

        expect(result).not_to be_successful
        expect(result.attributes[:error]).to eq 'unauthorized'
      end

      it 'when the password is wrong' do
        result = subject.login(email: user.email, password: '1234568')

        expect(result).not_to be_successful
        expect(result.attributes[:error]).to eq 'unauthorized'
      end

      it 'when the email does not exist before' do
        result = subject.login(email: 'test@tes.com', password: '12345678')

        expect(result).not_to be_successful
        expect(result.attributes[:error]).to eq 'unauthorized'
      end
    end
  end
end
