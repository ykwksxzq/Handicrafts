class Public::UsersController < ApplicationController

 def show
   @user = current_user
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

 private

 def user_params
   params.require(:user).permit(:nick_name, :introduction, :profile_image)
 end


end
