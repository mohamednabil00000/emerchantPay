# frozen_string_literal: true

require 'rails_helper'

class TestApplicationController < ApplicationController; end

RSpec.describe TestApplicationController, type: %i[api controller] do
  let(:admin) { create(:admin, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: admin.id, user_type: 'admin') }

  controller(TestApplicationController) do
    def index
      head :ok
    end
  end

  describe '#authorize' do
    context 'return unauthorized' do
      it 'session does not contain auth token' do
        get_request(path: :index)
        expect(response).to have_http_status(:unauthorized)
      end
      it 'token is fake' do
        session[:auth_token] = 'token'
        get_request(path: :index)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it 'returns created' do
      session[:auth_token] = token
      get_request(path: :index, token:)
      expect(response).to have_http_status(:ok)
    end
  end
end
