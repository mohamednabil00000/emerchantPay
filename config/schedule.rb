# frozen_string_literal: true

set :environment, ENV.fetch('RAILS_ENV', 'development')

every 1.hour do
  rake 'transactions:delete'
end
