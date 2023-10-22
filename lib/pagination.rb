# frozen_string_literal: true

class Pagination
  DEFAULT_LIMIT = 10

  attr_reader :limit, :page

  def initialize(page:, limit: nil)
    @page = page.to_i
    @limit = (limit || DEFAULT_LIMIT).to_i
  end

  def offset
    @offset ||= (page - 1) * limit
  end
end
