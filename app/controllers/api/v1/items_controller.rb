class Api::V1::ItemsController < ApplicationController
	#  :verity_authenticity_token
	# skip_before_action :check_loign

	def favorite
		item = Item.find(params[:id])
		if item.favorited_by(current_user)
			 # 移除最愛
			 current_user.items.delete(item)
			 render json: {status: '-'}
		  else
		   current_user.items << item
		  	# +最愛
		   render json: {status: 'favorited'}
		  end 
  end
end
