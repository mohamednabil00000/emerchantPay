# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminApi::TransactionsController, type: :routing do
  describe 'transaction routes' do
    it 'routes to #index' do
      expect(get: '/admin/transactions').to route_to('admin_api/transactions#index')
    end
  end
end
