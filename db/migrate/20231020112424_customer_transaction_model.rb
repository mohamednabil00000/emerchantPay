# frozen_string_literal: true

class CustomerTransactionModel < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :customer_transactions, id: :uuid do |t|
      t.uuid :uuid, null: false, index: { unique: true, name: 'unique_uuid' }
      t.string :email
      t.string :phone_number
      t.float :amount
      t.references :merchant, null: false

      t.timestamps
    end
  end
end
