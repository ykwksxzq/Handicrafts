class Public::PostCraftsController < ApplicationController
 before_action :authenticate_user!
 before_action :is_matching_login_user, only:[:show, :edit, :update, :destroy]

 def new
   @post_craft = PostCraft.new
   @tags = PostCraft.tag_counts_on(:tags).most_used(20)
 end

 def create
   @post_craft = PostCraft.new(post_craft_params)
   @post_craft.user_id = current_user.id

    if params[:post_craft][:status] == "published"
      if @post_craft.save(is_published: true)
       flash[:notice] = "作品を公開しました"
       redirect_to post_craft_path(@post_craft.id)
      else
       @tags = ActsAsTaggableOn::Tag.all
       flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
       render :new
      end
    else
      if @post_craft.save(is_draft: true)
       flash[:notice] = "下書きを保存しました"
       redirect_to mypage_path(current_user)
      else
        @tags = ActsAsTaggableOn::Tag.all
        flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
        render :new
      end
    end
 end

 def index
   @post_crafts = PostCraft.published.page(params[:page]).per(12).order(created_at: :desc)
   @post_crafts = PostCraft.published.search(params[:q])
   @tags = PostCraft.published.tag_counts_on(:tags).most_used(20).order(created_at: :desc)
   @post_crafts = @post_crafts.page(params[:page]).per(12).order(created_at: :desc)
   @genres = Genre.all
 end

 def genre_search
   @genre_id = params[:genre_id]
   @post_crafts = PostCraft.published.where(genre_id: @genre_id)
   @all_post_crafts = PostCraft.published.includes(:genre)
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

   if params[:post_craft][:status] == "published"
     if @post_craft.update(post_craft_params)
       flash[:notice] = "内容を更新し、作品を公開しました"
       redirect_to post_craft_path(@post_craft.id)
     else
       flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
       render :edit
     end
   else
     if @post_craft.update(post_craft_params)
       flash[:notice] = "下書きを更新しました"
       redirect_to post_craft_path(@post_craft.id)
     else
       flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
       render :edit
     end
   end
 end

 def destroy
   @post_craft = PostCraft.find(params[:id])
    if @post_craft.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to user_post_crafts_path
    end
 end

 def confirm
   @post_crafts = current_user.post_crafts.draft.page(params[:page]).per(12)
 end

 def tags
   @post_crafts = PostCraft.published.page(params[:page]).per(12).order(created_at: :desc)
   @tags = PostCraft.published.tag_counts_on(:tags).most_used(20).order(created_at: :desc)
   if @tag = params[:tag]
     @post_crafts = PostCraft.published.tagged_with(params[:tag]).page(params[:page]).per(12)
   end
 end

 def self.search(keyword)
   if params[:title, :introduction].present?
     @post_craft = PostCraft.self.search_by(keyword)
     @keyword = params[:title, :introduction]
   else
     @post_crafts = PostCraft.all
   end
 end


 private

 def post_craft_params
   params.require(:post_craft).permit(:user_id, :genre_id, :title, :introduction, :status, :image, :tag_list)
 end

 def tag_params
   params.require(:tag).permit(:name)
 end

 def genre_rarams
   params.require(:genre).permit(:name)
 end

 def is_matching_login_user
   @post_craft = PostCraft.find(params[:id])
   unless @post_craft.user.id == current_user.id
    redirect_to post_crafts_path
   end
 end

end