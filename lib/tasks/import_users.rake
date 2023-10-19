# frozen_string_literal: true

require 'csv'

namespace :import_users do
  desc 'import users'
  task :import_users, [:csv_file_path] => :environment do |_t, args|
    csv_file_path = args[:csv_file_path]
    CSV.foreach(csv_file_path, headers: true) do |row|
      row_hash = row.to_h
      user = User.create(row_hash.except('description'))
      next unless user.save

      Merchant.create!(user_id: user.id, description: row_hash['description']) if merchant?(row_hash['role'])
    end
  end

  def merchant?(role)
    role == 'merchant'
  end
end
