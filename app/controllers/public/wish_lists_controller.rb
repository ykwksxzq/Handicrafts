class Public::WishListsController < ApplicationController

  def index
    @wish_list = WishList.new
    @wish_lists = WishList.where(user_id: current_user.id)
    @genre = Genre.all
  end


  def create
    @wish_list = WishList.new(wish_list_params)
    @wish_list.user_id = current_user.id
    @wish_list.save
    redirect_to wish_lists_path
  end

  def edit
    @wish_list = WishList.find(params[:id])
  end

  def update
    @wish_list = WishList.find(params[:id])
    if @wish_list.update(wish_list_params)
      redirect_to wish_lists_path, notice: 'ほしいリストの更新が完了いたしました'
    else
      render :edit
    end
  end

  def destroy
    @wish_list = WishList.find(params[:id])
    @wish_list.destroy
    redirect_to wish_lists_path
  end



  private


  def wish_list_params
    params.require(:wish_list).permit(:user_id, :genre_id, :item_name, :memo)
  end

  def genre_rarams
    params.require(:genre).permit(:name)
  end

end
