# frozen_string_literal: true

module ApiHelper
  def append_auth_header(token)
    request.headers['Authorization'] = token
  end

  def post_request(path:, params: {}, token: nil)
    append_auth_header(token) if token
    post path, params:
  end

  def get_request(path:, params: {}, token: nil)
    append_auth_header(token) if token
    get path, params:
  end

  def delete_request(path:, params: {}, token: nil)
    append_auth_header(token) if token
    delete path, params:
  end

  def put_request(path:, params: {}, token: nil)
    append_auth_header(token) if token
    put path, params:
  end

  def patch_request(path:, params: {}, token: nil)
    append_auth_header(token) if token
    patch path, params:
  end

  def append_auth_token_session(token:)
    session[:auth_token] = token
  end
end
