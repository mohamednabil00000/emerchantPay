# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

describe 'import_users.rake' do
  it 'create admin and merchant users' do
    expect do
      run_task(task_name: 'import_users:import_users', argument: 'spec/tasks/users_csv.csv')
    end.to change { User.count }.by(2).and change { Merchant.count }.by(1)

    expect(Merchant.last.description).to eq 'good merchant'
    users = User.all
    expect(users.pluck(:email)).to match_array(%w[nabil@gmail.com mohamed@gmail.com])
    expect(users.pluck(:name)).to match_array(%w[mohamed adam])
  end
end

def run_task(task_name:, argument:)
  Rake::Task[task_name].invoke(argument)
end
