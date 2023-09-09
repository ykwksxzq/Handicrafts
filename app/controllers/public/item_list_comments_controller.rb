class Public::ItemListCommentsController < ApplicationController

  def create
    item_list = ItemList.find(params[:item_list_id])
    comment = current_user.item_list_comments.new(item_list_comment_params)
    comment.item_list_id = item_list.id
    comment.save
    redirect_to item_list_path(item_list)
  end

  private

  def item_list_comment_params
    params.require(:item_list_comment).permit(:user_id, :item_list_id, :comment)
  end


end
