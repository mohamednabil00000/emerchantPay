# frozen_string_literal: true

class TransactionsController < ApplicationController
  def index
    result = transaction_service.index
    @transactions = result.attributes[:transactions]
  end

  private

  def transaction_service
    @transaction_service ||= TransactionTypes::BaseService.new(
      page: params[:page], current_user: @current_user, user_type: @user_type
    )
  end
end
