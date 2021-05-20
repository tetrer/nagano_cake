class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  include ApplicationHelper

  def index
    @cart_items = current_customer.cart_items
    if @cart_items.blank?
      @subtotal = 0
    else
      @cart_items.each do |item|
        @subtotal = (@subtotal.to_i + item.product.price * item.quantity)
      end
    end
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)     #空のインスタンス取得 カスタマーIDの紐付け
    if @cart_item.quantity.present?     #@cart_itemのquantityが存在する場合、
      duplicate_cart_item = current_customer.cart_items.find_by(product_id: @cart_item.product.id)     #Product_IDの被っているItemを探し、
      if duplicate_cart_item.present?                               #被っているものがあれば
        @cart_item.quantity += duplicate_cart_item.quantity     #数を足し合わせて、
        duplicate_cart_item.destroy                             #かぶっているものを消す
      end
    end
    if @cart_item.save
      redirect_to cart_items_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    CartItem.find_by(id: params[:id]).update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    CartItem.find_by(id: params[:id]).destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all   #テスト時はログインしてないのでコメントアウト中
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id,
                                     :quantity)
  end
end
