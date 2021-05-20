class Admin::ProductsController < ApplicationController
  include ApplicationHelper
  # before_action :authenticate_admin!

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Product.new (product_params)
    if @product.save
      flash[:notice] = "You have created product successfully"
      redirect_to admin_product_path(@product.id)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "You have updated product successfully."
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :genre_id, :price, :image, :is_valid)
  end

end
