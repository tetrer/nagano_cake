class Public::CartItemsController < ApplicationController

  def index
    # @cart_items = CartItem.where(customer_id: 'current_customer_id')   #テスト時はログインしてないのでコメントアウト中
    # @cart_items = CartItem.where(customer_id: "1")   #テスト時用の記述（本番は削除）
    @cart_items = CartItem.all
    
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    # @cart_item.customer_id = current_customer_id   #テスト時はログインしてないのでコメントアウト中
    @cart_item.customer_id = "1"   #テスト時用の記述（本番は削除）
    @cart_item.quantity += params[:quantity].to_i
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
  end

  def destroy
  end

  # def destroy.all
  # end

  private

  def customer_params
    params.require(:cart_item).permit(:product_id,
                                     :customer_id,
                                     :quantity)
  end

end