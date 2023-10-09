class Public::FavoritesController < ApplicationController
 before_action :authenticate_user!
 
 def create
    post_craft = PostCraft.find(params[:post_craft_id])
    favorite = current_user.favorites.new(post_craft_id: post_craft.id)
    favorite.save
    flash[:notice] = "いいねしました"
    redirect_to post_craft_path(post_craft)
 end

 def destroy
    post_craft = PostCraft.find(params[:post_craft_id])
    favorite = current_user.favorites.find_by(post_craft_id: post_craft.id)
    favorite.destroy
    flash[:notice] = "いいねを外しました"
    redirect_to post_craft_path(post_craft)
 end


end
