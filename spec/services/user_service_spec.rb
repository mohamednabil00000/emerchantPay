# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserService do
  describe '#create_user' do
    let(:subject) { described_class.new }

    context 'when user is merchant' do
      it_behaves_like 'create user' do
        let(:user_hash) do
          {
            'name' => 'dummy',
            'email' => 'dummy@gmail.com',
            'password' => '12345678',
            'password_confirmation' => '12345678',
            'role' => 'merchant',
            'status' => 'active',
            'description' => 'test'
          }
        end

        let(:merchant_records_count) { 1 }
      end
    end

    context 'when user is admin' do
      it_behaves_like 'create user' do
        let(:user_hash) do
          {
            'name' => 'dummy',
            'email' => 'dummy@gmail.com',
            'password' => '12345678',
            'password_confirmation' => '12345678',
            'role' => 'admin',
            'status' => 'active',
            'description' => ''
          }
        end

        let(:merchant_records_count) { 0 }
      end
    end
  end
end
