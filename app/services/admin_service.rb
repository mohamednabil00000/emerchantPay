# frozen_string_literal: true

class AdminService
  def create(admin_hash)
    Admin.create(admin_hash)
  end
end
