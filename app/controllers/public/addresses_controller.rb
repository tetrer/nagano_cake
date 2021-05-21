class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @address_new = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "配送先を登録しました。"
      redirect_to addresses_path
    else
      flash[:alert] = "配送先を登録できませんでした。"
      @addresses = Address.where(customer_id: current_customer.id)
      redirect_to addresses_path
    end

  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "配送先を更新しました。"
      redirect_to addresses_path
    else
      flash[:alert] = "配送先を更新できませんでした。"
      render "edit"
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id,
                                     :name,
                                     :postal_code,
                                     :address)
  end

end
