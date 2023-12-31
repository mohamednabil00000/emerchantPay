# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminService do
  describe '#create' do
    let(:subject) { described_class.new }

    it_behaves_like 'create user' do
      let(:user_hash) do
        {
          'name' => 'dummy',
          'email' => 'dummy@gmail.com',
          'password' => '12345678',
          'password_confirmation' => '12345678',
          'status' => 'active'
        }
      end
      let(:admin_records_count) { 1 }
      let(:merchant_records_count) { 0 }
    end
  end
end
