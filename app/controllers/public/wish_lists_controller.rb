class Public::WishListsController < ApplicationController

  def show
    @wish_list = WishList.new
    @wish_lists = WishList.where(user_id: current_user.id).page(params[:page]).per(10)
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    if params[:genre_id].present?
     @genre = Genre.find(params[:genre_id])
     @wish_lists = @genre.wish_lists
     @wish_lists = @wish_lists.all.page(params[:page]).per(10)
    end
  end


  def create
    @wish_list = WishList.new(wish_list_params)
    @wish_list.user_id = current_user.id
    @wish_list.save
    redirect_to wish_list_path(current_user.id)
  end

  def edit
    @wish_list = WishList.find(params[:id])
  end

  def update
    @wish_list = WishList.find(params[:id])
    if @wish_list.update(wish_list_params)
      redirect_to wish_list_path(current_user.id), notice: 'ほしいものリストの更新が完了いたしました'
    else
      render :edit
    end
  end

  def destroy
    @wish_list = WishList.find(params[:id])
    @wish_list.destroy
    redirect_to wish_list_path(current_user.id), notice: 'ほしいものリストの項目を１件削除いたしました'
  end



  private


  def wish_list_params
    params.require(:wish_list).permit(:user_id, :genre_id, :item_name, :memo)
  end

  def genre_rarams
    params.require(:genre).permit(:name)
  end

end
