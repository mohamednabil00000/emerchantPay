# frozen_string_literal: true

RSpec.shared_examples 'create user' do
  it 'when created successfully' do
    expect do
      subject.create_user(user_hash)
    end.to change { User.count }.by(1).and change { Merchant.count }.by(merchant_records_count)
  end

  it 'when email is invalid' do
    user_hash['email'] = 'dummy'
    expect do
      subject.create_user(user_hash)
    end.to change { User.count }.by(0).and change { Merchant.count }.by(0)
  end

  it 'when password is not equal confirmation password' do
    user_hash['password'] = 'dummy'
    expect do
      subject.create_user(user_hash)
    end.to change { User.count }.by(0).and change { Merchant.count }.by(0)
  end
end
