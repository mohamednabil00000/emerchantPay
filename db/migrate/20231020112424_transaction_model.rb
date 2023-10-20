# frozen_string_literal: true

class TransactionModel < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.uuid :uuid, null: false, index: { unique: true, name: 'unique_uuid' }
      t.string :email
      t.string :phone_number
      t.float :amount

      t.timestamps
    end
  end
end
