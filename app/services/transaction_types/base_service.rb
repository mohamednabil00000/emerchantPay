# frozen_string_literal: true

module TransactionTypes
  class BaseService
    def initialize(args = {})
      @args = args
    end

    def create
      raise NotImplementedError
    end

    def index
      transactions = Transaction.includes(:merchant)
      num_of_pages = 1

      if pagination?
        num_of_pages = (transactions.size * 1.0 / pagination.limit * 1.0).ceil
        transactions = transactions.limit(pagination.limit).offset(pagination.offset)
      end

      ResultSuccess.new({ transactions:, num_of_pages: })
    end

    protected

    attr_reader :args

    def pagination?
      args&.dig(:page).present?
    end

    def pagination
      @pagination ||= Pagination.new(page: args&.dig(:page), limit: args&.dig(:limit))
    end
  end
end
