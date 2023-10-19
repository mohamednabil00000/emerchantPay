# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe '#authenticate' do
    let!(:user) { create(:user, email: 'test@test.com', password: '12345678', name: 'test') }

    context '#success' do
      it 'when login successfully' do
        post '/auth/login', params: { email: 'test@test.com', password: '12345678' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).keys).to contain_exactly('token')
      end
    end

    context '#failure' do
      it 'when the password is wrong' do
        post '/auth/login', params: { email: 'test@test.com', password: '1234568' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq 'unauthorized'
      end

      it 'when the email does not exist before' do
        post '/auth/login', params: { email: 'test@tes.com', password: '12345678' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq 'unauthorized'
      end
    end
  end
end
