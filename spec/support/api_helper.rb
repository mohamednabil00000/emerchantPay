# frozen_string_literal: true

module ApiHelper
  def append_auth_header(token)
    request.headers['Authorization'] = token
  end

  def append_user_type_header(user_type)
    request.headers['UserType'] = user_type
  end
end
