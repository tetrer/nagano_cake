module ApplicationHelper
  
  def full_title(title = "")
    base_title = "ながのCAKE"
		if admin_signed_in?
			base_title + " | " + "(管理者) #{title}"
		else
		  base_title + " | " + "#{title}"
		end
	end
	
	def full_name(customer)
		customer.last_name + customer.first_name
	end

	def kana_full_name(customer)
		customer.kana_last_name + customer.kana_first_name
	end

  # 税込価格
  def tax_price(price)
    (price * 1.1).floor
  end

  # 1商品当たりの小計
  def sub_price(sub)
    (tax_price(sub.product.price) * sub.quantity)
  end

  # 商品価格の小計（送料以外）
  def total_price(totals)
    price = 0
    totals.each do |total|
      price += sub_price(total)
    end
    return price
  end

  # 請求額（商品価格小計+送料）
  def billing(order)
    total_price(current_customer.cart_items) + order.freight
  end

end
