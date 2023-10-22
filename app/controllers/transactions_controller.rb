# frozen_string_literal: true

class TransactionsController < ApplicationController
  def index
    result = transaction_service.index
    @transactions = TransactionPresenter.transactions(transactions: result.attributes[:transactions])
    @num_of_pages = result.attributes[:num_of_pages]
  end

  private

  def transaction_service
    @transaction_service ||= TransactionTypes::BaseService.new(
      page: params[:page], limit: params[:limit], current_user: @current_user, user_type: @user_type
    )
  end
end
