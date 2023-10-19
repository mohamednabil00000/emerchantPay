# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthPresenter do
  let(:user) { create(:user, email: 'test@test.com', password: '12345678', name: 'test') }
  let(:token) { 'token' }

  describe '#login' do
    it 'present login data' do
      data = described_class.login(user:, token:)
      expected_json = {
        name: user.name,
        email: user.email,
        role: user.role,
        status: user.status,
        token:
      }
      expect(data).to eq expected_json
    end
  end
end
