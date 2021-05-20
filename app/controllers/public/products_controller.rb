class Public::ProductsController < ApplicationController
  def index
    @genres = Genre.all
    @products = Product.all
    @genre_1 = Genre.find(1)
    @genre_2 = Genre.find(2)
    @genre_3 = Genre.find(3)
    @genre_4 = Genre.find(4)
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
