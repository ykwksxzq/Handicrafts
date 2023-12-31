class Public::ItemListsController < ApplicationController
 before_action :authenticate_user!
 before_action :is_matching_login_user, only: [:edit, :update, :destroy]

 def new
   @item_list = ItemList.new
 end

 def create
   @item_list = ItemList.new(item_list_params)
   @item_list.user_id = current_user.id
   if @item_list.save
     flash[:notice] = "アイテムを投稿しました"
     redirect_to item_list_path(@item_list.id)
   else
     flash.now[:alert] ="登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
     render :new
   end
 end

 def index
   @item_lists = ItemList.all.page(params[:page]).per(12).order(created_at: :desc)
   @genres = Genre.all
 end

 def genre_index
   @item_lists = ItemList.all.page(params[:page]).per(12).order(created_at: :desc)
   @genres = Genre.all
   if params[:genre_id].present?
     @genre = Genre.find(params[:genre_id])
     @item_lists = @genre.item_lists
     @item_lists = @item_lists.all.page(params[:page]).per(12).order(created_at: :desc)
   end
 end


 def show
   @item_list = ItemList.find(params[:id])
   @item_list_comment = ItemListComment.new
 end

 def edit
   @item_list = ItemList.find(params[:id])
 end

 def update
   @item_list = ItemList.find(params[:id])
   if @item_list.update(item_list_params)
     flash[:notice] = "投稿を更新しました"
     redirect_to item_list_path(@item_list.id)
   else
     flash.now[:alert] ="登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
     render :edit
   end
 end

 def destroy
   @item_list = ItemList.find(params[:id])
   if @item_list.destroy
     flash[:notice] = "投稿を削除しました"
     redirect_to item_lists_path
   end
 end


 def self.search(keyword)
   if params[:item_name, :memo].present?
     @item_list = ItemList.search_by(keyword)
     @keyword = params[:item_name, :memo]
   else
     @item_lists = ItemList.all
   end
 end

 private

 def item_list_params
   params.require(:item_list).permit(:user_id, :genre_id, :item_name, :memo, :image)
 end

 def genre_rarams
   params.require(:genre).permit(:name)
 end

 def is_matching_login_user
   @item_list = ItemList.find(params[:id])
   unless @item_list.user.id == current_user.id
    redirect_to item_lists_path
   end
 end

end
