class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		@comment.item_id = params[:item_id]
		@comment.user_id = current_user.id
		# 上面二行可改成下面註解的。 
    

    if @comment.save
		  redirect_to item_path(params[:item_id]), notice: 'ok'
		else
		  render 'items/show'
			# redirect_to item_path(params[:item_id]), notice: 'fail'
	end
end

# @item = Item.find([:item_id])
# @comment = current_user.comments.build(comment_params, item: @item)
# @comment.item = @item


private

	def comment_params
		# params.require(:comment).permit(:content).merge(user: current_user)
		params.require(:comment).permit(:content)
	end




end



