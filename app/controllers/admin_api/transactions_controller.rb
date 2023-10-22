# frozen_string_literal: true

module AdminApi
  class TransactionsController < ApplicationController
    def index
      result = transaction_service.index
      @transactions = TransactionPresenter.transactions(transactions: result.attributes[:transactions])
      @num_of_pages = result.attributes[:num_of_pages]

      render json: { transactions: @transactions, num_of_pages: @num_of_pages }, status: :ok
    end

    private

    def transaction_service
      @transaction_service ||= TransactionTypes::BaseService.new(page: params[:page], limit: params[:limit])
    end
  end
end
