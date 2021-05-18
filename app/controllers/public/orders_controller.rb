class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
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
