class Admin::PostCommentsController < ApplicationController

def index
  @post_comments = PostComment.all
end

def show
  @post_comment = PostComment.find(params[:id])
end

def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_craft_path(params[:post_craft_id]), notice: "不適切なコメントを削除しました"
end


private

def post_comment_params
  params.require(:post_comment).permit(:user_id, :post_craft_id, :comment)
end

end


