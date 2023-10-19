# frozen_string_literal: true

class ConvertTotalTransactionSumFromIntToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column(:merchants, :total_transaction_sum, :float, default: 0.0)
  end
end
