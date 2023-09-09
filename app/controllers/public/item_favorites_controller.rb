class Public::ItemFavoritesController < ApplicationController

  def create
    item_list = ItemList.find(params[:item_list_id])
    item_favorite = current_user.item_favorites.new(item_list_id: item_list.id)
    item_favorite.save
    redirect_to item_list_path(item_list)
  end

  def destroy
    item_list = ItemList.find(params[:item_list_id])
    item_favorite = current_user.item_favorites.find_by(item_list_id: item_list.id)
    item_favorite.destroy
    redirect_to item_list_path(item_list)
  end

end
