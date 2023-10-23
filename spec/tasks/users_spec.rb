# frozen_string_literal: true

require 'rails_helper'

describe 'rake users:import', type: :task do
  it 'create admin and merchant users' do
    expect do
      task.invoke('spec/tasks/csv_files/users_csv.csv')
    end.to change { Admin.count }.by(1).and change { Merchant.count }.by(1)

    expect(Merchant.last.description).to eq 'good merchant'
    admin = Admin.last
    merchant = Merchant.last
    expect(admin.email).to eq 'nabil@gmail.com'
    expect(admin.name).to eq 'mohamed'
    expect(merchant.email).to eq 'mohamed@gmail.com'
    expect(merchant.name).to eq 'adam'
  end
end
