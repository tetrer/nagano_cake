class Public::OrdersController < ApplicationController
  include ApplicationHelper

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_customer.cart_items
		@order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method]
    )

    # total_priceに請求額を代入
    @order.total_price = billing(@order)

    # addressにaddressの値がはいっていれば
    if params[:order][:address_option] == "address"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.last_name + current_customer.first_name

    # addressにshipping_addressの値がはいっていれば
    elsif params[:order][:address_option] == "shipping_address"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address     = ship.address
      @order.name        = ship.name

    # addressにnew_addressの値がはいっていれば
    elsif params[:order][:address_option] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @ship = "1"

      # エラーメッセージ表示
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

	def create
    @order = current_customer.orders.new(order_params)
    @order.save
    flash[:notice] = "ご注文が確定しました。"
    redirect_to complete_orders_path

    # もし情報入力でnew_addressの場合ShippingAddressに保存
    if params[:order][:ship] == "1"
      current_customer.addresses.create(address_params)
    end

    # カート商品の情報を注文商品に移動
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      OrderDetail.create(
        product:        cart_item.product,
        order:          @order,
        quantity:       cart_item.quantity,
        subtotal_price: sub_price(cart_item)
      )
    end
    # 注文完了後、カート商品を空にする
    @cart_items.destroy_all
	end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

	def show
	  @order = Order.find(params[:id])
    @order_details = @order.order_details
	end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
