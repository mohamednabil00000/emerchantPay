# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_request

  protect_from_forgery
end
