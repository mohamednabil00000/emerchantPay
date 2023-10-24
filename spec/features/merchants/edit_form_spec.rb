# frozen_string_literal: true

require 'rails_helper'

describe 'Edit form', type: :feature do
  let!(:admin) do
    create(:admin, email: 'test@test.com', password: '12345678', password_confirmation: '12345678',
                   name: 'test')
  end

  let!(:merchant) { create(:merchant, email: 'merchant2@gmail.com') }
  let(:fill_in_args) do
    {
      'merchant[name]' => 'foo',
      'merchant[email]' => 'foo@gmail.com',
      'merchant[description]' => 'dummy one'
    }
  end

  before do
    login(user_type: 'admin', email: admin.email, password: admin.password)
    click_on 'Merchants'
    find_all('tr')[1].find('a', text: 'Edit').click
  end

  it 'check contents' do
    expect_admin_nav_bar(name: admin.name)
    expect(page).to have_content('Email Address')
    expect(page).to have_content('Name')
    expect(page).to have_content('Description')
    expect(page).to have_content('Status')
    expect(page).to have_button('Update')
  end

  context '#success' do
    let(:new_attrs) do
      {
        name: 'foo',
        email: 'foo@gmail.com',
        description: 'dummy one',
        status: 'inactive'
      }
    end
    it 'with description' do
      fill_in_inputs(args: fill_in_args)
      select('inactive', from: 'merchant[status]').select_option
      click_on 'Update'
      expect(merchant.reload).to have_attributes(new_attrs)
      expect(page).to have_content('Merchant was successfully updated')
      expect(page).to have_current_path('/merchants')
      expect_table_record(row: find_all('tr')[1],
                          values: ['foo', 'foo@gmail.com', 'dummy one', 'inactive'])
    end

    it 'with empty description' do
      fill_in_args['merchant[description]'] = ''
      new_attrs[:description] = ''
      fill_in_inputs(args: fill_in_args)
      select('inactive', from: 'merchant[status]').select_option
      click_on 'Update'
      expect(merchant.reload).to have_attributes(new_attrs)
      expect(page).to have_content('Merchant was successfully updated')
      expect(page).to have_current_path('/merchants')
      expect_table_record(row: find_all('tr')[1],
                          values: ['foo', 'foo@gmail.com', '', 'inactive'])
    end
  end

  context '#failure' do
    it 'without email' do
      fill_in_args['merchant[email]'] = ''
      fill_in_inputs(args: fill_in_args)
      expect do
        click_on 'Update'
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_current_path("/merchants/#{merchant.id}/edit")
      end.not_to(change { Merchant.count })
    end

    it 'without name' do
      fill_in_args['merchant[name]'] = ''
      fill_in_inputs(args: fill_in_args)
      expect do
        click_on 'Update'
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_current_path("/merchants/#{merchant.id}/edit")
      end.not_to(change { Merchant.count })
    end
  end
end
