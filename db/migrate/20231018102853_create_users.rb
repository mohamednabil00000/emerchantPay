# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true, name: 'unique_emails' }
      t.string :password_digest, null: false
      t.string :status, default: :active

      t.timestamps
    end
  end
end
