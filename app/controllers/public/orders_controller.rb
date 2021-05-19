class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_cart
		@order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method]
    )

    # total_priceに請求額を代入
    @order.total_price = billing(@order)

    # addressにaddressの値がはいっていれば
    if params[:order][:addresses] == "residence"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.residence
      @order.name        = current_customer.last_name +
                           current_customer.first_name

    # addressにshipping_addressの値がはいっていれば
    elsif params[:order][:addresses] == "shipping_addresses"
      ship = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.postal_code = ship.postal_code
      @order.address     = ship.address
      @order.name        = ship.name

    # addressにnew_addressの値がはいっていれば
    elsif params[:order][:addresses] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @ship = "1"

      # バリデーションがあるならエラーメッセージを表示
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  def create
  end

  def complete
  end

  def index
  end

  def show
  end
end
