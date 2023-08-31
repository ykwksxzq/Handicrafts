class Public::PostCraftsController < ApplicationController

 def new
   @post_craft = PostCraft.new
 end

 def create
    @post_craft = PostCraft.new(post_craft_params)
    @post_craft.user_id = current_user.id
    @post_craft.save
    redirect_to post_crafts_path
 end

 def index
    @post_crafts = PostCraft.all
 end

 def show
    @post_craft = PostCraft.find(params[:id])
 end


 private

  def post_craft_params
    params.require(:post_craft).permit(:user_id, :genre_id, :title, :introduction, :status, :image)
  end
end
