class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm

  end

  def create
    @order = Order.new(order_params)
    order.save
    redirect_to
  end

  def index
    @orders = Order.all
  end



  def complete

  end

  def show
    @order = Order.find(params[:id])
  end


  def order_params
    params.require(:order).permit(:freight, :total_price, :payment_method, :name, :postal_code, :address, :order_status)
  end
end
