class Public::UsersController < ApplicationController

 def show
   @user = User.find(params[:id])
   @post_crafts = PostCraft.published.where(user_id: params[:id]).page(params[:page]).per(3).order(created_at: :desc)
 end

 def index
  @post_craft = PostCraft.published.where(user_id: current_user.id).order(created_at: :desc)
  @post_crafts = @post_craft.page(params[:page]).per(12)
 end

 def user_post_lists
  @user = User.find(params[:id])
  @post_crafts = PostCraft.published.where(user_id: params[:id]).page(params[:page]).per(12).order(created_at: :desc)
 end

 def item_list
  @item_lists = ItemList.where(user_id: current_user.id).page(params[:page]).per(12)
 end

 def edit
  @user = User.find(current_user.id)
 end

 def update
  @user = User.find(current_user.id)
  if @user.update(user_params)
    flash[:notice] = '会員情報の更新が完了しました'
    redirect_to mypage_path(@user.id)
  else
    render :edit
  end
 end


 def unsubscribe
   @user = User.find(current_user.id)
 end

 def withdraw
  @user = User.find(current_user.id)
  @user.update(is_deleted: true)
  reset_session
  flash[:notice] = "退会処理を実行いたしました"
  redirect_to root_path
 end

 def favorites
  @favorites = Favorite.where(user_id: current_user.id).page(params[:page]).per(12)
 end

 def favorite_users
  @favorites = Favorite.where(user_id: current_user.id)
 end

 private

 def user_params
   params.require(:user).permit(:nick_name, :introduction, :profile_image, :is_deleted)
 end

 def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to user_path(current_user.id)
    end
 end
end
