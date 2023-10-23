# frozen_string_literal: true

require 'csv'

namespace :users do
  desc 'import users'
  task :import, [:csv_file_path] => :environment do |_t, args|
    csv_file_path = args[:csv_file_path]
    CSV.foreach(csv_file_path, headers: true) do |row|
      row_hash = row.to_h
      user_factory.create(row_hash['role'], row_hash.except('role'))
    end
  end

  def user_factory
    @user_factory ||= UserFactory.new
  end
end
