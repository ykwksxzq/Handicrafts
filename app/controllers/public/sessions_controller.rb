# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def user_state
    @user = User.find_by(email: params[:user][:email])
    if @user
     if @user.valid_password?(params[:user][:password]) && !@user.is_deleted
      flash[:danger] = '退会済みです。申し訳ございませんが、別のメールアドレスをお使いください'
      redirect_to new_user_session_path
     end
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
