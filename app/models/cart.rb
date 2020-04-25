class Cart 

	attr_reader :items  

	def initialize(items = [])
	  # []預設值
		@items = items
		# @items = []
		# 初始化預設值另外寫，才不會每丟一次東西之前的就不見。
	end

	def add_item(item_id)
		found_item = items.find { |item| item.item_id == item_id }
		
		if found_item
			found_item.increment(1)
		else 
			items << CartItem.new(item_id, 1)
		end
		# 如果找到回傳的item_id ，則增加1。
			
		# @items << item_id
		# 回傳放選的食物的地方
	end


	def empty?
		items.empty?
	end


	


	# def items
	# 	return @items	
	# end 寫去上面了

	def total
		result = items.reduce(0) { |sum, item| sum + item.total }
		# result = items.sum {|item| item.total} 跟上面結果依樣
		# 0是初始值，reduce方法是每一條加起來，用來累加用。

		# tmp = 0
		# @items.each do |item|
		# 	tmp += item.total
		# end
		#   return

		if Time.now.month == 4 and Time.now.day == 1
			result = result * 0.1
			# 0.1打一折
	  end
	    return result
	end


		def self.from_hash(hash = nil)
			if hash && hash["items"]

				items = []

				hash["items"].each do |item|
					items << CartItem.new(item["item_id"], item["quantity"])
			  end
			  # 可用mape改寫。

        # Cart::Cart會錯 建議修掉。
			  new(items)
			else
			 return new
			end
		end


	  def to_hash
	  	# items = [{ "item_id" => 1, "quantity" => 3 },
	    # 	 	 { "item_id" => 2, "quantity" => 2 }]

	   	# items = []

	   	# @items.each do |item|
	   	# 	items << { "item_id" => item.item_id, 
	   	# 	          "quantity" => item.quantity }
	   	# 塞回空陣列

	   	items = @items.map{ |item|
	   						{ "item_id" => item.item_id, 
	   		          "quantity" => item.quantity }
	   	}
	   	# 塞回空陣列，比較好的寫法。

	   	return { "items" => items }
	  end

  
end