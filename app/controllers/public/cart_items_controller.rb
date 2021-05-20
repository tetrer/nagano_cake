class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  include ApplicationHelper

  def index
    @cart_items = current_customer.cart_items
    if @cart_items.present?                 #ログインしている会員のカートにアイテムが存在すれば、
      @subtotal = total_price(@cart_items)  #合計金額を出し、(application_helperにあるヘルパーを持ってくる)
    else
      @subtotal = 0                         #なければ、合計金額を0とする。ないもんね、仕方ないね
    end
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)                                  #カスタマーIDを紐付けつつ空のインスタンス取得し
    if @cart_item.quantity.present?                                                                 #@cart_itemのquantityが存在する場合、
      duplicate_cart_item = current_customer.cart_items.find_by(product_id: @cart_item.product.id)  #product_idの被っているアイテムを探し、
      if duplicate_cart_item.present?                                                               #被っているものがあれば
        @cart_item.quantity += duplicate_cart_item.quantity                                         #数を足し合わせて、
        duplicate_cart_item.destroy                                                                 #かぶっているものを消して選手交代
      end
    end
    if @cart_item.save                            #保存に成功したら、
      redirect_to cart_items_path                 #カート一覧へ行き、
    else
      redirect_back(fallback_location: root_path) #失敗したらその場にとどまる、個数を入れてもう一回やってほしい！
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
    current_customer.cart_items.destroy_all #ログインしている会員がカートに持っているアイテムを全て破壊し尽くす！
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id,
                                     :quantity)
  end
end
