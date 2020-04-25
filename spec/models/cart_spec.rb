require 'rails_helper'


RSpec.describe Cart, type: :model do

	  let(:cart){Cart.new}
	  # 新增一台購物車，下面cart = Cart.new寫太多次

		describe "基本功能" do
    

			it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
				# cart = Cart.new
				# 新增一台購物車

				cart.add_item(1)
				expect(cart.empty?).to be false
				# empty?是空的嗎?
				# 可寫成 expect(cart).not_to be_empty
				# empty? = be_empty
		  end

		  it "加了相同種類的商品到購物車裡，（CartItem）並不會增加，商品的數量改變" do
		  	# cart = Cart.new

		  	3.times { cart.add_item(1) }
        2.times { cart.add_item(2) }
        2.times { cart.add_item(1) }
		  	# cart.add_item(1)
		  	# cart.add_item(3)
		  	# cart.add_item(2)
		  	# cart.add_item(1)
		  	
		  	expect(cart.items.count).to be 2
	    end


	    it "商品可以放到購物車裡，也可以再拿出來" do
	    	# cart = Cart.new

	    	# cat1 = Category.create(name: 'Cat1') 
	    	# cat1 = FactoryBot.create(:category) 
	    	# 做一個分類

	    	# i1 = cat1.items.create(name: 'item1', price: '100')
	    	# i2 = cat1.items.create(name: 'item2', price: '80')
	    	# i1 i2是分類做出來的商品

        # 因為有item工廠item.rb，所以改成以下寫法
	    	i1 = FactoryBot.create(:item)
	    	i2 = FactoryBot.create(:item)

	    	# Act
	    	3.times { cart.add_item(i1.id) }
	    	2.times { cart.add_item(i2.id) }

	    	# expect(cart.items.first.item).to be_a Item
	    	# 確認是一個餐點          ^一個方法
	    	# expect(cart.items.first.item.price).to be i1.price
	    	# 確認餐點名稱
	    	expect(cart.items.first.item).to be_an Item
	      expect(cart.items.first.item.price).to be i1.price
	    end

	    	it "可以計算整台購物車的總消費金額" do
	    	 # cart = Cart.new

	    	 i1 = FactoryBot.create(:item, price: 50)
         i2 = FactoryBot.create(:item, price: 100)

	    	 3.times { cart.add_item(i1.id) }
	    	 2.times { cart.add_item(i2.id) }

	    	 expect(cart.total).to be 350
	    	end



	    	it "折扣全館一折" do
	    	 # cart = Cart.new
	    	 i1 = FactoryBot.create(:item, price: 50 )
  	     i2 = FactoryBot.create(:item, price: 100 )

	    	 3.times { cart.add_item(i1.id) }
	    	 2.times { cart.add_item(i2.id) }

	    	 t = Time.local(2008, 4, 1, 10, 5, 0)
	    	 Timecop.travel(t)
	    	 # 時間點套件

	    	 expect(cart.total).to be 35.0
	    	 # expect(cart.items.first.item).to eq 35.0
	    	 # 兩個都可，下面是比值，上面是比object id。
	    	end
   
end


		describe "進階功能" do


		  it "可以將購物車內容轉換成 Hash，存到 Session 裡" do
	  	 # cart = Cart.new

	  	 i1 = FactoryBot.create(:item)
	     i2 = FactoryBot.create(:item)

	     3.times { cart.add_item(i1.id) }
		   2.times { cart.add_item(i2.id) }

	     expect(cart.to_hash).to eq cart_hash
	                # ^私有方法
	  end



    it "hash 還原購物車" do
    	# cart = Cart.new
    	cart = Cart.from_hash(cart_hash)

		  expect(cart.items.count).to be 2
    end


end

    private


    def cart_hash
    {
	   	 "items" => [
	   	 	 { "item_id" => 1, "quantity" => 3 },
	   	 	 { "item_id" => 2, "quantity" => 2 }
	   	 ]
	   }
	  end


end
