# frozen_string_literal: true

class MerchantsController < ApplicationController
  before_action :admin?
  before_action :current_merchant, only: %i[edit update destroy]

  # GET /merchants
  def index
    result = merchant_service.index(page: params[:page], limit: params[:limit])
    @merchants = result.attributes[:merchants]
    @num_of_pages = result.attributes[:num_of_pages]
  end

  # GET /merchants/:id/edit
  def edit; end

  # PATCH/PUT /merchants/:id
  def update
    result = merchant_service.update(merchant: current_merchant, new_attrs: merchant_params)
    if result.successful?
      flash[:notice] = I18n.t('errors.messages.merchant_successfully_updated')
      redirect_to action: 'index'
    else
      flash[:notice] = result.attributes[:errors]
      redirect_to action: 'edit'
    end
  end

  # DELETE /merchants/:id
  def destroy
    result = merchant_service.destroy(merchant: current_merchant)
    flash[:notice] = if result.successful?
                       I18n.t('errors.messages.merchant_successfully_destroyed')
                     else
                       result.attributes[:errors]
                     end
    redirect_to action: 'index'
  end

  private

  def current_merchant
    @current_merchant ||= Merchant.find(params[:id])
  end

  def validate_user_permission
    head :unauthorized unless admin?
  end

  def merchant_params
    params.require(:merchant).permit(:name, :email, :status, :description)
  end

  def merchant_service
    @merchant_service ||= MerchantService.new
  end
end
