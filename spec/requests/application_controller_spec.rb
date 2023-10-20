# frozen_string_literal: true

require 'rails_helper'

class TestController < ApplicationController; end

RSpec.describe TestController, type: %i[api controller] do
  include JsonWebToken

  let(:admin) { create(:admin, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: admin.id) }

  controller(TestController) do
    def index
      head :created
    end
  end

  def make_request(params: {}, token: nil, user_type: 'admin')
    append_auth_header(token) if token
    append_user_type_header(user_type)
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
