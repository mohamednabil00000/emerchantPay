# frozen_string_literal: true

require 'rails_helper'

class TestController < Api::ApiController; end

RSpec.describe TestController, type: %i[api controller] do
  let(:admin) { create(:admin, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: admin.id, user_type: 'admin') }

  controller(TestController) do
    def index
      head :ok
    end
  end

  describe '#authenticate_request' do
    it 'return unauthorized' do
      get_request(path: :index)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns created' do
      get_request(path: :index, token:)
      expect(response).to have_http_status(:ok)
    end
  end
end
