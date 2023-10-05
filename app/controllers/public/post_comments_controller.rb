class Public::PostCommentsController < ApplicationController

def create
  post_craft = PostCraft.find(params[:post_craft_id])
  comment = current_user.post_comments.new(post_comment_params)
  comment.post_craft_id = post_craft.id
  comment.save
  flash[:notice] = "コメントを送信しました"
  redirect_to post_craft_path(post_craft.id)
end

def destroy
  PostComment.find(params[:id]).destroy
  flash[:notice] = "コメントを削除しました"
  redirect_to post_craft_path(params[:post_craft_id])
end

private

def ensure_correct_user
  @post_comment = PostComment.find(params[:id])
 unless @post_comment.user == current_end_user
  flash[:notice] = "投稿者以外のコメントは削除できません"
  redirect_to post_craft_path
 end
end

def post_comment_params
  params.require(:post_comment).permit(:user_id, :post_craft_id,:comment)
end

end

