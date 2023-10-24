# frozen_string_literal: true

module FeatureHelper
  def login(user_type:, email:, password:)
    visit '/'
    fill_in 'email', with: email
    fill_in 'password', with: password
    choose(option: user_type)

    click_on 'Login'
  end

  def fill_in_inputs(args: {})
    args.each { |k, v| (fill_in k, with: v) }
  end

  def expect_table_content(labels:)
    within '.table' do
      labels.each { |label| expect(page).to have_content(label) }
    end
  end

  def expect_table_record(row:, values:)
    values.each { |value| expect(row).to have_content(value) }
  end

  def expect_admin_nav_bar(name:)
    within '.navbar' do
      expect(page).to have_content("Welcome #{name}")
      expect(page).to have_content('Transactions')
      expect(page).to have_content('Merchants')
    end
  end

  def expect_merchant_nav_bar(name:)
    within '.navbar' do
      expect(page).to have_content("Welcome #{name}")
      expect(page).to have_content('Transactions')
    end
  end
end
