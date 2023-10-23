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
      @transactions = Transaction.sort_by_created_at.includes(:merchant)
      @transactions = @transactions.where(merchant_id: current_user.id) if merchant?

      num_of_pages = 1

      if pagination?
        num_of_pages = pagination.num_of_pages
        @transactions = @transactions.limit(pagination.limit).offset(pagination.offset)
      end

      ResultSuccess.new({ transactions: @transactions, num_of_pages: })
    end

    protected

    attr_reader :args

    def pagination?
      args&.dig(:page).present?
    end

    def merchant?
      args[:user_type] == 'merchant'
    end

    def current_user
      args[:current_user]
    end

    def pagination
      @pagination ||= Pagination.new(count: @transactions.size, page: args&.dig(:page), limit: args&.dig(:limit))
    end
  end
end
