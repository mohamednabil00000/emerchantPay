# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true, name: 'unique_merchants_emails' }
      t.string :password_digest, null: false
      t.string :status, default: :active
      t.text :description
      t.decimal :total_transaction_sum, default: 0.0

      t.timestamps
    end
  end
end
