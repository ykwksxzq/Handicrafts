class Admin::PostCraftsController < ApplicationController
  before_action :authenticate_admin!

  def index
   @post_crafts = PostCraft.published.page(params[:page]).per(12)
  end

  def show
   @post_craft = PostCraft.find(params[:id])
  end

  private

  def post_craft_params
    params.require(:post_craft).permit(:user_id, :genre_id, :title, :introduction, :status, :image, :tag_list)
  end

end
