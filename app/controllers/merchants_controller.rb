# frozen_string_literal: true

class MerchantsController < ApplicationController
  before_action :validate_user_permission
  before_action :current_merchant, only: %i[edit update destroy]

  # GET /merchants
  def index
    @merchants = Merchant.all
  end

  # GET /merchants/:id/edit
  def edit; end

  # PATCH/PUT /merchants/:id
  def update
    if @current_merchant.update(merchant_params)
      flash[:notice] = I18n.t('errors.messages.merchant_successfully_updated')
      redirect_to action: 'index'
    else
      flash[:notice] = @current_merchant.errors.full_messages
      redirect_to action: 'edit'
    end
  end

  # DELETE /merchants/:id
  def destroy
    flash[:notice] = if @current_merchant.destroy
                       I18n.t('errors.messages.merchant_successfully_destroyed')
                     else
                       @current_merchant.errors.full_messages
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
end
