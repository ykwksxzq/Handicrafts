class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :destroy]

 def show
   @user = User.find(params[:id])
   @post_crafts = PostCraft.published.where(user_id: params[:id]).page(params[:page]).per(3).order(created_at: :desc)
 end

 def index
   @post_craft = current_user.post_crafts.published.order(created_at: :desc)
   @post_crafts = @post_craft.page(params[:page]).per(12)
 end

 def user_post_lists
   @user = User.find(params[:id])
   @post_crafts = PostCraft.published.where(user_id: params[:id]).page(params[:page]).per(12).order(created_at: :desc)
 end

 def user_item_lists
   @user = User.find(params[:id])
   @item_lists = ItemList.where(user_id: params[:id]).page(params[:page]).per(12).order(created_at: :desc)
 end

 def item_list
   @item_lists = current_user.item_lists.page(params[:page]).per(12)
 end

 def edit
   @user = User.find(current_user.id)
 end

 def update
   @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "会員情報の更新が完了しました"
      redirect_to mypage_path(@user.id)
    else
      flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認の上再度お試しください"
      render :edit
    end
 end


 def unsubscribe
   @user = User.find(current_user.id)
 end

 def destroy
   current_user.update(is_withdrawn: true)
   sign_out_and_redirect(current_user)
   flash[:notice] = "退会処理を実行いたしました"
   redirect_to root_path
 end

 def favorites
   @favorites = current_user.favorites.page(params[:page]).per(12)
 end

 def item_favorites
   @item_favorites = current_user.item_favorites.page(params[:page]).per(12)
 end

 private

 def user_params
   params.require(:user).permit(:nick_name, :introduction, :email, :profile_image)
 end

 def ensure_guest_user
   if current_user.guest_user?
     flash[:alert] =  "ゲストユーザーはプロフィール編集できません"
     redirect_to mypage_path(current_user.id)
   end
 end
end
