# frozen_string_literal: true

require 'rails_helper'

describe 'rake transactions:delete', type: :task do
  include_context 'charge transaction record from one hour ago'

  it 'deleting transactions older than one hour' do
    expect do
      task.execute
    end.to change { Transaction.count }.by(-1)
  end
end
