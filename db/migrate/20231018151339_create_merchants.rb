# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.references :user, index: true, null: false
      t.text :description
      t.integer :total_transaction_sum, default: 0

      t.timestamps
    end
  end
end
