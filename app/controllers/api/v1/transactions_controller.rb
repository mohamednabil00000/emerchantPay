# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < Api::ApiController
      before_action :check_merchant_status, only: %i[create]

      # POST /api/v1/transaction
      def create
        transaction_type_service = trasaction_factory.call(create_transaction_params)
        result = transaction_type_service.create
        if result.successful?
          render json: TransactionPresenter.transaction(transaction: result.attributes[:transaction]), status: :created
        else
          render json: result.attributes, status: :bad_request
        end
      end

      private

      def create_transaction_params
        params.require(:transaction).permit(:uuid, :transaction_type, :amount, :customer_email, :customer_phone,
                                            :status, :merchant_id, :parent_uuid)
      end

      def trasaction_factory
        @trasaction_factory ||= TransactionFactory.new
      end

      def check_merchant_status
        return if @user_type == 'merchant' && @current_user.status == 'active'

        render json: { errors: [I18n.t('errors.messages.user_should_be_active_merchant')] },
               status: :unauthorized
      end
    end
  end
end
