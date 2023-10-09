class Public::ItemFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
   item_list = ItemList.find(params[:item_list_id])
   item_favorite = current_user.item_favorites.new(item_list_id: item_list.id)
   item_favorite.save
   flash[:notice] = "いいねしました"
   redirect_to item_list_path(item_list)
  end

  def destroy
   item_list = ItemList.find(params[:item_list_id])
   item_favorite = current_user.item_favorites.find_by(item_list_id: item_list.id)
   item_favorite.destroy
   flash[:notice] = "いいねを外しました"
   redirect_to item_list_path(item_list)
  end

end
