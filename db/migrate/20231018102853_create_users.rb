# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, index: true, unique: true
      t.string :password_digest, null: false
      t.string :role, null: false
      t.string :status, default: :active

      t.timestamps
    end
  end
end