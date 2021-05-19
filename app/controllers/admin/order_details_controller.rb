class Admin::OrderDetailsController < ApplicationController
<<<<<<< HEAD
  include ApplicationHelper
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_details_path
    else
      render show
    end
    
    
    if !@order_details.present?
      @subtotal = 0
    else
      @order_details.each do |order_detail|
        @subtotal = (@subtotal.to_i + order_detail.product.price * order_detail.quantity)
      end
    end
    
    private
    def order_detail_params
      params.require(:order_detail).permit(:produciton_status)
    end
=======

  def update
>>>>>>> origin/develop
  end
end
