class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

end