class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  include ApplicationHelper


  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_details = @order_detail.order.order_details
    if @order_detail.update(order_detail_params)
      if @order_detail.production_status == "製作中"
        @order_detail.order.update(order_status: 2)
      elsif
        @order_detail.production_status == "製作完了"
        if @order_details.where(production_status: "製作完了").count ==  @order_details.count
          @order_detail.order.update(order_status: 3)
        end
      end

      flash[:notice] = "製作ステータスを変更しました"
      redirect_to admin_order_path(@order_detail.order)
    else
      render "show"
    end

  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
