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
      @transactions = Transaction.includes(:merchant)
      @transactions = @transactions.where(merchant_id: current_user.id) if merchant?
      @transactions = @transactions.sort_by_created_at.paginate(page: args&.dig(:page))

      ResultSuccess.new({ transactions: @transactions })
    end

    protected

    attr_reader :args

    def merchant?
      args[:user_type] == 'merchant'
    end

    def current_user
      args[:current_user]
    end
  end
end
