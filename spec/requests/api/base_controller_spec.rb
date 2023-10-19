# frozen_string_literal: true

require 'rails_helper'

module Api
  class TestController < Api::BaseController; end
end

RSpec.describe Api::TestController, type: %i[api controller] do
  include JsonWebToken

  let(:user) { create(:user, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: user.id) }

  controller(Api::TestController) do
    def index
      head :created
    end
  end

  def make_request(params: {}, token: nil)
    append_auth_header(token) if token
    get :index, params:
  end

  describe '#authenticate_request' do
    it 'return unauthorized' do
      make_request
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns created' do
      make_request(token:)
      expect(response).to have_http_status(:created)
    end
  end
end
