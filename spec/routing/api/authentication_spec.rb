# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::AuthenticationController, type: :routing do
  describe 'routing' do
    it 'routes to #login' do
      expect(post: '/auth/login').to route_to('api/authentication#login')
    end
  end
end
