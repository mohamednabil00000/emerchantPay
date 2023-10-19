# frozen_string_literal: true

require 'csv'

namespace :import_users do
  desc 'import users'
  task :import_users, [:csv_file_path] => :environment do |_t, args|
    csv_file_path = args[:csv_file_path]
    CSV.foreach(csv_file_path, headers: true) do |row|
      user_service.create_user(row.to_h)
    end
  end

  def user_service
    @user_service ||= UserService.new
  end
end
