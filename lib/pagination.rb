# frozen_string_literal: true

class Pagination
  DEFAULT_LIMIT = 10

  attr_reader :limit, :page, :count

  def initialize(count:, page:, limit: nil)
    @page = page.to_i
    @limit = (limit || DEFAULT_LIMIT).to_i
    @count = count
  end

  def offset
    @offset ||= (page - 1) * limit
  end

  def num_of_pages
    (count * 1.0 / limit * 1.0).ceil
  end
end
