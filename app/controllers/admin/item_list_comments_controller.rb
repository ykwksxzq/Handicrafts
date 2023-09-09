class Admin::ItemListCommentsController < ApplicationController

def index
    @item_list_comments = ItemListComment.all
end

def show
    @item_list_comment = ItemListComment.find(params[:id])
end

def destroy
    ItemListComment.find(params[:id]).destroy
    redirect_to admin_item_list_comments_path(params[:item_list_id]), notice: "不適切なコメントを削除しました"
end

def item_list_comment_params
  params.require(:item_list_comment).permit(:user_id, :item_list_id, :comment)
end

end
