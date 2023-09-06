class Public::PostCommentsController < ApplicationController

def create
    post_craft = PostCraft.find(params[:post_craft_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_craft_id = post_craft.id
    comment.save
    redirect_to post_craft_path(post_craft.id)
end

def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_craft_path(params[:post_craft_id])
end

private

def ensure_correct_user
    @post_comment = PostComment.find(params[:id])
    unless @post_comment.user == current_end_user
      redirect_to post_craft_path, notice: "投稿者以外コメントは削除できません。"
    end
end

def post_comment_params
  params.require(:post_comment).permit(:user_id, :post_craft_id,:comment)
end

end

