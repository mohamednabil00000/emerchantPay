# frozen_string_literal: true

RSpec.shared_examples 'user authenticate request service' do
  context 'returns success' do
    it 'return current user' do
      result = subject.authenticate_request(auth_header:, user_type_header:)
      expect(result).to be_successful
      expect(result.attributes[:current_user]).to eq current_user
    end
  end

  context 'returns failure' do
    let(:fake_token) { 'token' }
    it 'when token is fake' do
      result = subject.authenticate_request(auth_header: fake_token, user_type_header:)
      expect(result).not_to be_successful
    end

    it 'when user type does not exist' do
      result = subject.authenticate_request(auth_header:, user_type_header: nil)
      expect(result).not_to be_successful
    end
  end
end
