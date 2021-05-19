class Admin::OrderDetailsController < ApplicationController
  include ApplicationHelper
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      flash[:success] = "制作ステータスを変更しました"
      render 'order/show'
    else
      render "show"
    end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:produciton_status)
	end

end
