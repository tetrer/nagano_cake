class Admin::OrderDetailsController < ApplicationController
  include ApplicationHelper

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
<<<<<<< HEAD
      flash[:success] = "制作ステータスを変更しました"
=======
      flash[:success] = "製作ステータスを変更しました"
>>>>>>> origin/develop
      redirect_to admin_order_path(@order_detail.order)
    else
      render "show"
    end

  end

  private
  def order_detail_params
<<<<<<< HEAD
    params.require(:order_detail).permit(:order_id, :product_id, :quantity, :subtotal_price, :production_status)
  end

=======
    params.require(:order_detail).permit(:production_status)
  end
>>>>>>> origin/develop
end
