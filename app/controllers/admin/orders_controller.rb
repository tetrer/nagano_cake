class Admin::OrdersController < ApplicationController
<<<<<<< HEAD
  include ApplicationHelper
  
  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

end
=======
  def show
  end

  def index
  end

  def update
  end
end
>>>>>>> origin/develop
