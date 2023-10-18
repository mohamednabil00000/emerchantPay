# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  enum statuses: %i[active inactive]
  enum roles: %i[admin merchant]

  validates :email, :name, presence: true
  validates :password, length: { minimum: 8, maximum: 16, too_short: 'should be more than 7 chars',
                                 too_long: 'should be less than 17 chars' }, if: :password_required?
  validates :email, format: { with: /\A.+@.+\.\w{2,6}\Z/, message: 'invalid format' }, if: :email_required?
  validates_presence_of :password_confirmation, if: :password_digest_changed?
  validates :status, inclusion: { in: statuses }
  validates :role, inclusion: { in: roles }

  scope :active, -> { where(status: :active) }
  private

  def password_required?
    password.present?
  end

  def email_required?
    email.present?
  end
end
