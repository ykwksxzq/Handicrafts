class Public::ItemListCommentsController < ApplicationController

def create
  item_list = ItemList.find(params[:item_list_id])
  comment = current_user.item_list_comments.new(item_list_comment_params)
  comment.item_list_id = item_list.id
  comment.save
  flash[:notice] = "コメントを送信しました"
  redirect_to item_list_path(item_list)
end

def destroy
  ItemListComment.find(params[:id]).destroy
  flash[:notice] = "コメントを削除しました"
  redirect_to item_list_path(params[:item_list_id])
end

private

def ensure_correct_user
   @item_list_comment = ItemListComment.find(params[:id])
  unless @item_list_comment.user == current_end_user
   flash[:notice] = "投稿者以外のコメントは削除できません"
   redirect_to item_list_path
  end
end

private

def item_list_comment_params
  params.require(:item_list_comment).permit(:user_id, :item_list_id, :comment)
end


end
