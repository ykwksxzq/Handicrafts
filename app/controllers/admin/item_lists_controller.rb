class Admin::ItemListsController < ApplicationController

  def index
    @item_lists = ItemList.all.page(params[:page]).per(12)
  end

  def show
    @item_list = ItemList.find(params[:id])
  end
end
