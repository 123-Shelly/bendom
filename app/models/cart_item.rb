class CartItem
	attr_reader :item_id, :quantity
	# 把item_id跟quantity取出來，
	# 實體變數取一樣的名稱，可讀。


	def initialize(item_id, quantity = 1)
		@item_id = item_id
		@quantity = quantity
	end
	# 初始化，存東西的地方



	def increment(amount = 1)
		@quantity += amount
	end


	def item
		Item.find(item_id)	
	end


	def total
		item.price * quantity
	end
	# 單價


end