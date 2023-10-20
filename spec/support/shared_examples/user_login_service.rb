# frozen_string_literal: true

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
      expect(result.attributes[:error]).to eq 'unauthorized'
    end

    it 'when the password is wrong' do
      result = subject.login(email: user.email, password: '1234568', user_type:)

      expect(result).not_to be_successful
      expect(result.attributes[:error]).to eq 'unauthorized'
    end

    it 'when the email does not exist before' do
      result = subject.login(email: 'test@tes.com', password: '12345678', user_type:)

      expect(result).not_to be_successful
      expect(result.attributes[:error]).to eq 'unauthorized'
    end
  end
end
