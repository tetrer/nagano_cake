class Public::AddressesController < ApplicationController

  def index
    @address_new = Address.new
    # @addresses = Address.where(customer_id: 'current_customer_id')   #テスト時はログインしてないのでコメントアウト中
    @addresses = Address.where(customer_id: "1")   #テスト時用の記述（本番は削除）
  end

  def create
    @address = Address.new(address_params)
    # @address.customer_id = current_customer_id   #テスト時はログインしてないのでコメントアウト中
    @address.customer_id = "1"   #テスト時用の記述（本番は削除）
    @address.save
    redirect_to address_path(@address)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
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
