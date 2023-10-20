# frozen_string_literal: true

RSpec.shared_examples 'user login controller' do
  context '#success' do
    it 'when login successfully' do
      make_request(params: { email: 'test@test.com', password: '12345678' }, user_type:)

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)

      expect(body.keys).to match_array(%w[token name email status])
      expect(body['name']).to eq user.name
      expect(body['status']).to eq user.status
      expect(body['email']).to eq user.email
    end
  end

  context '#failure' do
    it 'when the password is wrong' do
      make_request(params: { email: 'test@test.com', password: '1234568' }, user_type:)

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']).to eq 'unauthorized'
    end

    it 'when the email does not exist before' do
      make_request(params: { email: 'test@tes.com', password: '12345678' }, user_type:)

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']).to eq 'unauthorized'
    end
  end
end
