# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthService do
  include JsonWebToken

  describe '#login' do
    let(:subject) { described_class.new }

    context 'when user is admin' do
      it_behaves_like 'user login service' do
        let(:user) { create(:admin, email: 'test@test.com', password: '12345678', name: 'test') }
        let(:inactive_user) do
          create(:admin, email: 'test2@test.com', password: '12345678', name: 'test2', status: :inactive)
        end
        let(:user_type) { 'admin' }
      end
    end

    context 'when user is merchant' do
      it_behaves_like 'user login service' do
        let(:user) { create(:merchant, email: 'test@test.com', password: '12345678', name: 'test') }
        let(:inactive_user) do
          create(:merchant, email: 'test2@test.com', password: '12345678', name: 'test2', status: :inactive)
        end
        let(:user_type) { 'merchant' }
      end
    end
  end

  describe '#authenticate_request' do
    let(:auth_header) { jwt_encode(user_id: current_user.id) }
    context 'when user is admin' do
      it_behaves_like 'user authenticate request service' do
        let(:current_user) { create(:admin, email: 'test@gmail.com') }
        let(:user_type_header) { 'admin' }
      end
    end

    context 'when user is admin' do
      it_behaves_like 'user authenticate request service' do
        let(:current_user) { create(:merchant, email: 'test@gmail.com') }
        let(:user_type_header) { 'merchant' }
      end
    end
  end
end
