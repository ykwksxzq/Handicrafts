class Public::WishListsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
   @wish_list = WishList.new
   @wish_lists = WishList.where(user_id: current_user.id).page(params[:page]).per(10)
   @genres = Genre.all
   if params[:genre_id].present?
     @genre = Genre.find(params[:genre_id])
     @wish_lists = @genre.wish_lists
     @wish_lists = @wish_lists.where(user_id: current_user.id).page(params[:page]).per(10)
   end
  end

  def create
   @wish_list = WishList.new(wish_list_params)
   @wish_list.user_id = current_user.id
   @wish_lists = WishList.where(user_id: current_user.id).page(params[:page]).per(10)


   if @wish_list.save
     flash[:notice] = 'ほしいものリストに登録いたしました'
     redirect_to wish_lists_path
   else
     @genres = Genre.all
     flash[:alert] = '登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください'
     render :index
   end
  end

  def edit
   @wish_list = WishList.find(params[:id])
  end

  def update
   @wish_list = WishList.find(params[:id])
   if @wish_list.update(wish_list_params)
     flash[:notice] = 'ほしいものリストの更新が完了いたしました'
     redirect_to wish_lists_path
   else
     @genres = Genre.all
     flash[:alert] = '登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください'
     render :edit
   end
  end

  def destroy
   @wish_list = WishList.find(params[:id])
   @wish_list.destroy
   flash[:notice] = 'ほしいものリストの項目を１件削除いたしました'
   redirect_to wish_lists_path
  end

  private

  def wish_list_params
   params.require(:wish_list).permit(:user_id, :genre_id, :item_name, :memo)
  end

  def genre_rarams
   params.require(:genre).permit(:name)
  end

  def is_matching_login_user
   @wish_list = WishList.find(params[:id])
   unless @wish_list.user.id == current_user.id
    redirect_to wish_lists_path
   end
  end

end
