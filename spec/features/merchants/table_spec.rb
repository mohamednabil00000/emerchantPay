# frozen_string_literal: true

require 'rails_helper'

describe 'merchants table', type: :feature do
  include_context 'authorize transaction record'

  let!(:admin) do
    create(:admin, email: 'test@test.com', password: '12345678', password_confirmation: '12345678',
                   name: 'test')
  end

  let!(:merchant2) { create(:merchant, email: 'merchant2@gmail.com') }

  before do
    login(user_type: 'admin', email: admin.email, password: admin.password)
    click_on 'Merchants'
  end

  describe '#table' do
    it 'check contents' do
      expect_admin_nav_bar(name: admin.name)
      expect_table_content(labels: ['ID', 'Name', 'Email', 'Description', 'Total transactions sum', 'Status',
                                    'Created at', 'Actions'])
    end

    it 'check records' do
      expect_table_record(row: find_all('tr')[1],
                          values: [merchant.id, merchant.name, merchant.email,
                                   merchant.description, merchant.total_transaction_sum,
                                   merchant.status, merchant.created_at,
                                   'Edit', 'Delete'])

      expect_table_record(row: find_all('tr')[2],
                          values: [merchant2.id, merchant2.name, merchant2.email,
                                   merchant2.description, merchant2.total_transaction_sum,
                                   merchant2.status, merchant2.created_at,
                                   'Edit', 'Delete'])
    end
  end

  describe '#actions' do
    describe '#edit' do
      it 'redirects to edit merchant form' do
        row = find_all('tr')[1]
        row.find('a', text: 'Edit').click
        expect(page).to have_content("Update #{merchant.name}")
        expect(page).to have_current_path("/merchants/#{merchant.id}/edit")
      end
    end

    describe '#destroy' do
      context 'when destroy is successful' do
        it 'redirects to table view again' do
          expect do
            row = find_all('tr')[2]
            row.find('a', text: 'Delete').click

            expect(page).to have_content('Merchant was successfully destroyed')
            expect(page).to have_current_path('/merchants')
          end.to change { find_all('tr').size }.by(-1)
        end
      end

      context 'when destroy is not successful' do
        it 'get error msg' do
          expect do
            row = find_all('tr')[1]
            row.find('a', text: 'Delete').click

            expect(page).to have_content('Cannot delete Merchant has any transaction!')
            expect(page).to have_current_path('/merchants')
          end.not_to(change { find_all('tr').size })
        end
      end
    end
  end
end
