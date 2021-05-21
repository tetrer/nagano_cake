class Public::ProductsController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    # @product.save
    @cart_item = CartItem.new
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :is_valid)
  end

end
