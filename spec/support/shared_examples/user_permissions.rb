# frozen_string_literal: true

RSpec.shared_examples 'if user is not admin' do
  it 'returns unauthorized' do
    expect(response).to have_http_status(:unauthorized)
  end
end
