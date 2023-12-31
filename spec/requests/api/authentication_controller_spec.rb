# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::AuthenticationController, type: %i[api controller] do
  describe '#authenticate' do
    context 'when user is admin' do
      it_behaves_like 'user login controller' do
        let!(:user) { create(:admin, email: 'test@test.com', password: '12345678', name: 'test') }
        let(:user_type) { 'admin' }
      end
    end

    context 'when user is merchant' do
      it_behaves_like 'user login controller' do
        let!(:user) { create(:merchant, email: 'test@test.com', password: '12345678', name: 'test') }
        let(:user_type) { 'merchant' }
      end
    end
  end
end
