# frozen_string_literal: true

class CreateCustomerTransactionTypes < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :customer_transaction_types, id: :uuid do |t|
      t.uuid 'uuid', null: false
      t.string 'type', null: false
      t.string 'status', null: false, default: :error
      t.uuid 'parent_id', null: false
      t.timestamps
    end

    add_foreign_key :customer_transaction_types, :customer_transactions, column: :parent_id, primary_key: :uuid
  end
end
