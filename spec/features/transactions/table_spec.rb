# frozen_string_literal: true

require 'rails_helper'

describe 'transactions table', type: :feature do
  include_context 'charge transaction record'

  context 'when user is admin' do
    let!(:admin) do
      create(:admin, email: 'test@test.com', password: '12345678', password_confirmation: '12345678',
                     name: 'test')
    end

    before { login(user_type: 'admin', email: admin.email, password: admin.password) }

    it 'checks contents' do
      expect_admin_nav_bar(name: admin.name)
      expect_table_content(labels: ['UUID', 'Type', 'Status', 'Customer email', 'Customer phone', 'Amount',
                                    'Reference transaction', 'Created at', 'Merchant name'])
    end

    it 'checks records' do
      expect_table_record(row: find_all('tr')[1],
                          values: [authorize_transaction.uuid, authorize_transaction.type, authorize_transaction.status,
                                   authorize_transaction.email, authorize_transaction.phone_number,
                                   authorize_transaction.amount, authorize_transaction.parent_uuid,
                                   authorize_transaction.created_at, authorize_transaction.merchant.name])

      expect_table_record(row: find_all('tr')[2],
                          values: [charge_transaction.uuid, charge_transaction.type, charge_transaction.status,
                                   charge_transaction.email, charge_transaction.phone_number,
                                   charge_transaction.amount, charge_transaction.parent_uuid,
                                   charge_transaction.created_at, charge_transaction.merchant.name])
    end
  end

  context 'when user is merchant' do
    before { login(user_type: 'merchant', email: merchant.email, password: merchant.password) }

    it 'check contents' do
      expect_merchant_nav_bar(name: merchant.name)
      expect_table_content(labels: ['UUID', 'Type', 'Status', 'Customer email', 'Customer phone', 'Amount',
                                    'Reference transaction', 'Created at'])
    end

    it 'check records' do
      expect_table_record(row: find_all('tr')[1],
                          values: [authorize_transaction.uuid, authorize_transaction.type, authorize_transaction.status,
                                   authorize_transaction.email, authorize_transaction.phone_number,
                                   authorize_transaction.amount, authorize_transaction.parent_uuid,
                                   authorize_transaction.created_at])

      expect_table_record(row: find_all('tr')[2],
                          values: [charge_transaction.uuid, charge_transaction.type, charge_transaction.status,
                                   charge_transaction.email, charge_transaction.phone_number,
                                   charge_transaction.amount, charge_transaction.parent_uuid,
                                   charge_transaction.created_at])
    end
  end
end
