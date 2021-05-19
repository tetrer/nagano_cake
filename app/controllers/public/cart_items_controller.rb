class Public::CartItemsController < ApplicationController
  include ApplicationHelper

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if !@cart_items.present?
      @subtotal = 0
    else
      @cart_items.each do |item|
        @subtotal = (@subtotal.to_i + item.product.price * item.quantity)
      end
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)     #空のインスタンス取得
    @cart_item.customer_id = current_customer.id     #カスタマーIDの紐付け

    duplicate_cart_item = CartItem.find_by(product_id: @cart_item.product.id, customer_id: current_customer.id)     #Product_IDの被っているItemを探す
    if not params[:cart_item][:quantity].empty? == true     #カートが空ではなく、
      if duplicate_cart_item                               #被っているものがあれば
        @cart_item.quantity += duplicate_cart_item.quantity     #数を足し合わせて、
        duplicate_cart_item.destroy                             #がぶっているものを消す
      end
    end

    @cart_item.save

    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.where(customer_id: 'current_customer_id')   #テスト時はログインしてないのでコメントアウト中

    # @cart_items = CartItem.where(customer_id: "1")   #テスト時用の記述（本番は削除）
    # @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id,
                                     :customer_id,
                                     :quantity)
  end
end
