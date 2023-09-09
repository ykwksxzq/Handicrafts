class Admin::ItemListsController < ApplicationController
  
  def index
    @item_lists = ItemList.all
  end
  
  def show
    @item_list = ItemList.find(params[:id])
  end
end
