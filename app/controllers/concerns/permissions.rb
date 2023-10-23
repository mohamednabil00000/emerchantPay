# frozen_string_literal: true

module Permissions
  def admin?
    head :unauthorized unless @user_type == 'admin'
  end

  def merchant?
    head :unauthorized unless @user_type == 'merchant'
  end
end
