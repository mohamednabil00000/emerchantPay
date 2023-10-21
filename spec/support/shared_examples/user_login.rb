# frozen_string_literal: true

RSpec.shared_examples 'user login controller' do
  context '#success' do
    it 'when login successfully' do
      post_request(params: { email: 'test@test.com', password: '12345678', user_type: }, path: :login)

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
      post_request(params: { email: 'test@test.com', password: '1234568', user_type: }, path: :login)

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['errors']).to match_array(['Wrong email or Password!'])
    end

    it 'when the email does not exist before' do
      post_request(params: { email: 'test@tes.com', password: '12345678', user_type: }, path: :login)

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['errors']).to match_array(['Wrong email or Password!'])
    end
  end
end

RSpec.shared_examples 'user login service' do
  context '#success' do
    it 'when login successfully' do
      result = subject.login(email: user.email, password: user.password, user_type:)
      expect(result).to be_successful
      expect(result.attributes.keys).to match_array(%i[user token])
      expect(result.attributes[:user]).to eq user
    end
  end

  context '#failure' do
    it 'when user is inactive' do
      result = subject.login(email: inactive_user.email, password: inactive_user.password, user_type:)

      expect(result).not_to be_successful
      expect(result.attributes[:errors]).to match_array(['Wrong email or Password!'])
    end

    it 'when the password is wrong' do
      result = subject.login(email: user.email, password: '1234568', user_type:)

      expect(result).not_to be_successful
      expect(result.attributes[:errors]).to match_array(['Wrong email or Password!'])
    end

    it 'when the email does not exist before' do
      result = subject.login(email: 'test@tes.com', password: '12345678', user_type:)

      expect(result).not_to be_successful
      expect(result.attributes[:errors]).to match_array(['Wrong email or Password!'])
    end
  end
end

RSpec.shared_examples 'user login presenter' do
  it 'present login data' do
    data = described_class.login(user:, token:)
    expected_json = {
      name: user.name,
      email: user.email,
      status: user.status,
      token:
    }
    expect(data).to eq expected_json
  end
end
