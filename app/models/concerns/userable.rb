# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern

  included do
    require 'securerandom'
    include EmailValidatable

    has_secure_password

    enum statuses: %i[active inactive]

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 8, maximum: 16, too_short: I18n.t('errors.messages.password_too_short'),
                                   too_long: I18n.t('errors.messages.password_too_long') }, if: :password_required?
    validates_presence_of :password_confirmation, if: :password_digest_changed?
    validates :status, inclusion: { in: statuses }

    scope :active, -> { where(status: :active) }

    private

    def password_required?
      password.present?
    end
  end

  class_methods do
    def find_authenticated(args = {})
      user = find_by(email: args[:email], status: :active)
      user if user&.authenticate(args[:password])
    end
  end
end
