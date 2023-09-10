class Public::PostCraftsController < ApplicationController

 def new
   @post_craft = PostCraft.new
   @tags = PostCraft.tag_counts_on(:tags).most_used(20)
 end

 def create
    @post_craft = PostCraft.new(post_craft_params)
    @post_craft.user_id = current_user.id
    if @post_craft.save
     flash[:notice] = "作品を投稿しました"
     redirect_to post_craft_path(@post_craft.id)
    else
     @tags = ActsAsTaggableOn::Tag.all
     render :new
    end
 end

 def index
    @post_crafts = PostCraft.published
    @post_crafts = PostCraft.search(params[:q])
    @tags = PostCraft.tag_counts_on(:tags).most_used(20)
 end

 def show
    @post_craft = PostCraft.find(params[:id])
    @post_comment = PostComment.new
    @tags = @post_craft.tag_counts_on(:tags)
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

 def tags
  @tags = PostCraft.tag_counts_on(:tags).order('count DESC')     # 全タグ(Postモデルからtagsカラムを降順で取得)
  @tag = params[:tag]   # タグ検索用
  @post_craft = PostCraft.tagged_with(params[:tag])   # タグに紐付く投稿
 end

 def self.search(keyword)
    if params[:title, :introduction, :tag_list].present?
      @post_craft = PostCraft.published.where('title LIKE ? or introduction LIKE ? or tag_list LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
      @keyword = params[:title, :introduction, :tag_list]
    else
      @post_crafts = PostCraft.all
    end
 end


 private

  def post_craft_params
    params.require(:post_craft).permit(:user_id, :genre_id, :title, :introduction, :status, :image, :tag_list)
  end
end
