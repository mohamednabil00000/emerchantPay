# frozen_string_literal: true

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
