# frozen_string_literal: true

class TransactionModel < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :transactions, id: :uuid do |t|
      t.uuid :uuid, null: false, index: { unique: true, name: 'unique_uuid' }
      t.string :email
      t.string :phone_number
      t.decimal :amount
      t.references :merchant, null: false
      t.string :type, null: false
      t.string :status, null: false, default: :error
      t.uuid :parent_uuid

      t.timestamps
    end
  end
end
