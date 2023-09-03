class Public::UsersController < ApplicationController

 def show
   @user = User.find(params[:id])
 end

 def index
  @post_crafts = PostCraft.published.where(user_id: current_user.id)
 end

 def edit
  @user = User.find(current_user.id)
 end

 def update
  @user = User.find(current_user.id)
  if @user.update(user_params)
      redirect_to mypage_path(@user.id), notice: '会員情報の更新が完了しました。'
  else
      render :edit
  end
 end

 def favorites
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
