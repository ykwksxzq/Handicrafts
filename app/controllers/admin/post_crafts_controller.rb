class Admin::PostCraftsController < ApplicationController

def index
  @post_crafts = PostCraft.published
end

def show
  @post_craft = PostCraft.find(params[:id])
end

end
