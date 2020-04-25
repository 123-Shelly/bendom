class ItemsController < ApplicationController

		before_action :find_item, only: [:show, :edit, :update, :destroy, :add_to_cart ]
		                        # except: [:index, :new, :create] 另一個寫法
		# :show, :edit, :update, :destroy 先找好東西
		

		def index
			@items = Item.all
			# 這邊名字沒有一定
			# 只撈沒有暫時刪掉的
			# @items = Item.available 類別方法
			# scope :available, -> { where(deleted_at: nil)} 包去models，不要放controller。
			# scope :cheap, -> { where("price <= 80")} 只是示範
		end
		
    def show
			@comment = Comment.new
			@comments = @item.comments.includes(:user) 
			# 上面改善n+1 query的問題，用IN
			# @comments = @item.comments.order(id: :desc) <!-- .order(id: :desc) 讓他正向排列-->
			# find_item
			# 上面有寫before_action 
			# begin
				# @item = Item.find(params[:id])
			# rescue
			# redirect_to items_path, notice: "沒有品項!"
			# end
		end

		def new
			@item = Item.new
		end


		def create
			@item = Item.new(item_params)

			if @item.save
				# flash[:notice] = "成功新增餐點!"

				redirect_to items_path, notice: "成功新增餐點!"
		  else
		  	render :new
		  end
		end



		def destroy
			# find_item
			# item = Item.find(params[:id])
			@item.destroy
			# @item.update(deleted_at: Time.now)
			redirect_to items_path, notice: "成功刪除餐點!"
		end



	


		def edit
			  # find_item
				# @item = Item.find(params[:id])
				# @item = Item.new 不顯示暫存資料
		end


		def update
			  # find_item
				# @item = Item.find(params[:id])

				if @item.update(item_params)
					 redirect_to items_path, notice: "成功更新餐點!"
				else
					 render :edit
				end
		end


    def add_to_cart
    	# cart = Cart.from_hash(session[:carty])
    	current_cart.add_item(@item.id)
    	session[:carty] = current_cart.to_hash

		  redirect_to root_path, notice: "已加入購物車!"
   	end
   	#之前寫的測試





	private

	def find_item
		  @item = Item.find(params[:id])
			# @item = Item.find_by!(id: params[:id], deleted_at: nil )
	end
	# 一直重複所以做一個一起用


  def item_params
  		params.require(:item).permit(:name, 
  																 :price,
  																 :category_id, 
  																 :description,
  																 :cover,
  																 :spec)
  end



end
