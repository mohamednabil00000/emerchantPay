# frozen_string_literal: true

ENV.each_key do |key|
  env key.to_sym, ENV.fetch(key, nil)
end

set :environment, ENV.fetch('RAILS_ENV', nil)

every 1.hour do
  rake 'transactions:delete'
end
