class Public::PostCraftsController < ApplicationController

 def new
   @post_craft = PostCraft.new
 end

 def create
    @post_craft = PostCraft.new(post_craft_params)
    @post_craft.user_id = current_user.id
    @post_craft.save
     redirect_to post_crafts_path(@post_craft)
 end

 def index
    @post_crafts = PostCraft.published
    @post_crafts = @post_crafts.where('location LIKE ?', "%#{params[:search]}%") if params[:search].present?
 end

 def show
    @post_craft = PostCraft.find(params[:id])
    @post_comment = PostComment.new
 end

 def edit
   @post_craft = PostCraft.find(params[:id])
 end

 def update
  @post_craft = PostCraft.find(params[:id])
  if @post_craft.update(post_craft_params)
   flash[:notice] = "You have updated post successfully."
   redirect_to post_craft_path(@post_craft.id)
  else
   render :edit
  end
 end

 def destroy
    @post_craft = PostCraft.find(params[:id])
    @post_craft.destroy
    redirect_to user_post_crafts_path
 end

 def confirm
  @post_crafts = current_user.post_crafts.draft
 end

 def self.search(keyword)
    if params[:title, :introduction].present?
      @post_craft = PostCraft.published.where('title LIKE ? or introduction LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
      @keyword = params[:title, :introduction]
    else
      @post_crafts = PostCraft.all
    end
 end


 private

  def post_craft_params
    params.require(:post_craft).permit(:user_id, :genre_id, :title, :introduction, :status, :image)
  end
end
