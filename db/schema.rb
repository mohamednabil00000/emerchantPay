# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_231_020_112_424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'admins', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email'
    t.string 'password_digest', null: false
    t.string 'status', default: 'active'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'unique_emails', unique: true
  end

  create_table 'merchants', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email'
    t.string 'password_digest', null: false
    t.string 'status', default: 'active'
    t.text 'description'
    t.float 'total_transaction_sum', default: 0.0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'unique_merchants_emails', unique: true
  end

  create_table 'transactions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'uuid', null: false
    t.string 'email'
    t.string 'phone_number'
    t.float 'amount'
    t.bigint 'merchant_id', null: false
    t.string 'type', null: false
    t.string 'status', default: 'error', null: false
    t.uuid 'parent_uuid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['merchant_id'], name: 'index_transactions_on_merchant_id'
    t.index ['uuid'], name: 'unique_uuid', unique: true
  end
end
