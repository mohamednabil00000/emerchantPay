# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MerchantsController, type: %i[api controller] do
  let(:admin) { create(:admin, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: admin.id, user_type: 'admin') }

  before do
    append_auth_token_session(token:)
  end

  describe '#index' do
    let!(:merchant1) { create(:merchant, email: 'test1@gmail.com') }
    let!(:merchant2) { create(:merchant, email: 'test2@gmail.com') }

    it 'renders a successful response' do
      get_request(path: :index)
      expect(assigns(:merchants)).to match_array [merchant1, merchant2]
    end

    it_behaves_like 'if user is not admin' do
      let(:token) { jwt_encode(user_id: merchant1.id, user_type: 'merchant') }
      let!(:subject) { get_request(path: :index) }
    end
  end

  describe '#update' do
    let!(:merchant) { create(:merchant, email: 'test1@gmail.com') }
    let(:new_attributes) do
      {
        name: 'User',
        email: 'test2@gmail.com',
        description: 'hello world'
      }
    end

    it_behaves_like 'if user is not admin' do
      let(:token) { jwt_encode(user_id: merchant.id, user_type: 'merchant') }
      let!(:subject) { put_request(path: :update, params: { id: merchant.id, merchant: new_attributes }) }
    end

    it 'updates merchant successfully' do
      put_request(path: :update, params: { id: merchant.id, merchant: new_attributes })
      merchant.reload
      expect(merchant.name).to eq new_attributes[:name]
      expect(merchant.email).to eq new_attributes[:email]
      expect(merchant.description).to eq new_attributes[:description]
      expect(flash[:notice]).to eq 'Merchant was successfully updated.'
      expect(response).to redirect_to merchants_url
    end

    it 'invalid email' do
      new_attributes[:email] = 'sdsds'
      put_request(path: :update, params: { id: merchant.id, merchant: new_attributes })
      merchant.reload

      expect(flash[:notice]).to match_array ['Email invalid format']
      expect(response).to redirect_to "#{merchant_url(merchant)}/edit"
    end
  end

  describe '#destroy' do
    it_behaves_like 'if user is not admin' do
      let(:merchant) { create(:merchant, email: 'test1@gmail.com') }
      let(:token) { jwt_encode(user_id: merchant.id, user_type: 'merchant') }
      let!(:subject) { delete_request(path: :destroy, params: { id: merchant.id }) }
    end
    context 'when merchant has no trasactions' do
      let!(:merchant) { create(:merchant, email: 'test1@gmail.com') }
      it 'destroyed successfully' do
        expect do
          delete_request(path: :destroy, params: { id: merchant.id })
        end.to change(Merchant, :count).by(-1)

        expect(flash[:notice]).to eq 'Merchant was successfully destroyed.'
        expect(response).to redirect_to merchants_url
      end
    end

    context 'when merchant has transactions' do
      include_context 'charge transaction record'
      it 'merchant will not be destroyed' do
        expect do
          delete_request(path: :destroy, params: { id: merchant.id })
        end.not_to change(Merchant, :count)

        expect(flash[:notice]).to match_array ['Cannot delete Merchant has any transaction!']
        expect(response).to redirect_to merchants_url
      end
    end
  end
end
