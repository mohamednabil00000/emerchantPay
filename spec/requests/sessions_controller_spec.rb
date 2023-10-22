# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: %i[api controller] do
  describe '#create' do
    let!(:user) { create(:admin, email: 'test@test.com', password: '12345678', name: 'test') }
    let(:user_type) { 'admin' }
    it 'when login is successful' do
      post_request(params: { email: 'test@test.com', password: '12345678', user_type: }, path: :create)
      expect(session).to have_key(:auth_token)
      expect(session[:auth_token]).not_to be_nil
      # TO-DO test the redirect
    end

    it 'when login is unsuccessful' do
      post_request(params: { email: 'test@test.com', password: '123456789', user_type: }, path: :create)
      expect(session[:auth_token]).to be_nil
      expect(flash[:notice]).to eq 'Wrong email or Password!'
      expect(response).to redirect_to('/')
    end
  end
end
