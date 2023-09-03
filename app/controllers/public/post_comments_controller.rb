class Public::PostCommentsController < ApplicationController

def create
    post_craft = PostCraft.find(params[:post_craft_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_craft_id = post_craft.id
    comment.save
    redirect_to post_craft_path(post_craft.id)
end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end

