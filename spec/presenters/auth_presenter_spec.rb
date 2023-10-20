# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthPresenter do
  let(:token) { 'token' }

  describe '#login' do
    context 'present login admin data' do
      it_behaves_like 'user login presenter' do
        let(:user) { create(:admin, email: 'test@test.com', password: '12345678', name: 'test') }
      end
    end

    context 'present login merchant data' do
      it_behaves_like 'user login presenter' do
        let(:user) { create(:merchant, email: 'test@test.com', password: '12345678', name: 'test') }
      end
    end
  end
end
