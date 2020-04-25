require 'rails_helper'

RSpec.describe CartItem, type: :model do
	describe "基本功能" do
	  it "每個 Cart Item 都可以計算它自己的金額" do
	  	 cart = Cart.new

	     # 因為有item工廠item.rb，所以改成以下寫法
	  	 i1 = create(:item, price: 50 )
	  	 i2 = create(:item, price: 100 )

	  	 # Act
	  	 3.times { cart.add_item(i1.id) }
	   	 2.times { cart.add_item(i2.id) }

	   	 # expect(cart.items.first.item).to be_a Item
	   	 # 確認是一個餐點          ^一個方法
		   expect(cart.items.first.total).to be 150
		   # 確認餐點名稱
		   end
		end
end
