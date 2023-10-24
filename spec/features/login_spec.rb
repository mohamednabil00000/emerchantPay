# frozen_string_literal: true

require 'rails_helper'

describe 'the signin process', type: :feature do
  it 'check page contents' do
    visit '/'
    expect(page).to have_content('Email Address')
    expect(page).to have_content('Password')
    expect(page).to have_content('Merchant')
    expect(page).to have_content('Admin')
    expect(page).to have_button('Login')
  end

  context 'successful login' do
    context 'when user is admin' do
      let!(:admin) do
        create(:admin, email: 'test@test.com', password: '12345678', password_confirmation: '12345678', name: 'test')
      end

      it 'redirects to the transactions page' do
        login(user_type: 'admin', email: admin.email, password: admin.password)

        expect(page).to have_current_path('/transactions')
      end
    end
    context 'when user is merchant' do
      let!(:merchant) do
        create(:merchant, email: 'test@test.com', password: '12345678', password_confirmation: '12345678',
                          name: 'test')
      end

      it 'redirects to the transactions page' do
        login(user_type: 'merchant', email: merchant.email, password: merchant.password)

        expect(page).to have_current_path('/transactions')
      end
    end
  end

  context 'failed login' do
    it 'redirect to same page' do
      login(user_type: 'merchant', email: 'test@test.com', password: '12345678')

      expect(page).to have_content 'Wrong email or Password!'
      expect(page).to have_current_path('/')
    end
  end
end
