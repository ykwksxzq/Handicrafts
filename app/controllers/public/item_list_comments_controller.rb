class Public::ItemListCommentsController < ApplicationController
  before_action :authenticate_user!

 def create
  item_list = ItemList.find(params[:item_list_id])
  comment = current_user.item_list_comments.new(item_list_comment_params)
  comment.item_list_id = item_list.id
  if comment.save
    flash[:notice] = "コメントを送信しました"
    redirect_to item_list_path(item_list.id)
  else
    flash[:alert] = "コメントを送信できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
    redirect_to item_list_path(item_list.id)
  end
 end

 def destroy
  ItemListComment.find(params[:id]).destroy
  flash[:notice] = "コメントを削除しました"
  redirect_to item_list_path(params[:item_list_id])
 end

 private

 def item_list_comment_params
  params.require(:item_list_comment).permit(:user_id, :item_list_id, :comment)
 end

end
