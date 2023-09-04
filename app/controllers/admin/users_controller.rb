class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
   @user = User.find(params[:id])
  end

 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: '会員情報の更新が完了しました。'
  else
      render :edit
  end
 end

 private

 def user_params
   params.require(:user).permit(:nick_name, :introduction, :profile_image, :is_deleted)
 end

end

