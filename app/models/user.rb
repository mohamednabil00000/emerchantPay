# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  enum statuses: %i[active inactive]
  enum roles: %i[admin merchant]

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 16, too_short: I18n.t('errors.messages.password_too_short'),
                                 too_long: I18n.t('errors.messages.password_too_long') }, if: :password_required?
  validates :email, format: { with: /\A.+@.+\.\w{2,6}\Z/, message: I18n.t('errors.messages.invalid_format') },
                    if: :email_required?
  validates_presence_of :password_confirmation, if: :password_digest_changed?
  validates :status, inclusion: { in: statuses }
  validates :role, inclusion: { in: roles }

  scope :active, -> { where(status: :active) }

  def self.find_authenticated(args = {})
    user = find_by(email: args[:email])
    user if user&.authenticate(args[:password])
  end

  private

  def password_required?
    password.present?
  end

  def email_required?
    email.present?
  end
end
