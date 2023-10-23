# frozen_string_literal: true

namespace :transactions do
  desc 'deleting transactions older than an hour'
  task delete: :environment do
    Transaction.older_than_one_hour.delete_all
  end
end
