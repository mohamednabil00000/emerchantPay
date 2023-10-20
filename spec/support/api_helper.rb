# frozen_string_literal: true

module ApiHelper
  def append_auth_header(token)
    request.headers['Authorization'] = token
  end
end
