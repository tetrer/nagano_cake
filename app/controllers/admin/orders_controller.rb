class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  include ApplicationHelper

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    if @order.order_status == "入金確認"
      @order_details.each do |order_detail|
        order_detail.update(production_status: 1)
      end
    end
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end

