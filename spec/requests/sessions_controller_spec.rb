# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: %i[api controller] do
  describe '#create' do
    let!(:user) { create(:admin, email: 'test@test.com', password: '12345678', name: 'test') }
    let(:user_type) { 'admin' }

    context 'when user is admin' do
      it_behaves_like 'successful login through sessions controller'
    end
    context 'when user is merchant' do
      it_behaves_like 'successful login through sessions controller' do
        let!(:user) { create(:merchant, email: 'test@test.com', password: '12345678', name: 'test') }
        let(:user_type) { 'merchant' }
      end
    end

    it 'when login is unsuccessful' do
      post_request(params: { email: 'test@test.com', password: '123456789', user_type: }, path: :create)
      expect(session[:auth_token]).to be_nil
      expect(flash[:notice]).to eq 'Wrong email or Password!'
      expect(response).to redirect_to('/')
    end
  end
end
