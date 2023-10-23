# frozen_string_literal: true

class Transaction < ApplicationRecord
  include EmailValidatable

  belongs_to :merchant

  enum statuses: %i[approved reversed refunded error]

  validates :uuid, presence: true, uniqueness: true
  validates :status, inclusion: { in: statuses }

  scope :sort_by_created_at, -> { order(:created_at) }

  def approved?
    status == 'approved'
  end

  def convert_to_refunded!
    update!(status: :refunded)
  end

  def convert_to_reversed!
    update!(status: :reversed)
  end
end
