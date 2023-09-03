class Public::FavoritesController < ApplicationController

 def create
    post_craft = PostCraft.find(params[:post_craft_id])
    favorite = current_user.favorites.new(post_craft_id: post_craft.id)
    favorite.save
    redirect_to post_craft_path(post_craft)
 end

 def destroy
    post_craft = PostCraft.find(params[:post_craft_id])
    favorite = current_user.favorites.find_by(post_craft_id: post_craft.id)
    favorite.destroy
    redirect_to post_craft_path(post_craft)
 end


end
