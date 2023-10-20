# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  subject { create(:merchant, email: 'test@gmail.com') }

  it_behaves_like 'validations'

  it_behaves_like 'scopes' do
    let!(:user1) { create(:merchant, status: :active, email: 'email1@gmail.com') }
    let!(:user2) { create(:merchant, status: :active, email: 'email2@gmail.com') }
    let!(:user3) { create(:merchant, status: :inactive, email: 'email3@gmail.com') }
  end

  it_behaves_like 'find_authenticated' do
    let(:user) { create(:merchant, email: 'test@test.com', password: '12345678', name: 'test') }
    let(:inactive_user) do
      create(:merchant, email: 'test2@test.com', password: '12345678', name: 'test2', status: :inactive)
    end
  end
end
