# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :routing do
  describe 'transaction routes' do
    it 'routes to #create' do
      expect(post: '/api/v1/transactions').to route_to('api/v1/transactions#create')
    end
  end
end
