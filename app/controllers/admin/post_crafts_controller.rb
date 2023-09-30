class Admin::PostCraftsController < ApplicationController

def index
  @post_crafts = PostCraft.published.page(params[:page]).per(12)
end

def show
  @post_craft = PostCraft.find(params[:id])
end

end
