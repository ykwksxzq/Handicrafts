class Public::ItemListsController < ApplicationController

 def new
  @item_list = ItemList.new
 end

 def create
  @item_list = ItemList.new(item_list_params)
  @item_list.user_id = current_user.id
  @item_list.save
  redirect_to item_list_path(@item_list.id)
 end


 def index
  @item_lists = ItemList.all.page(params[:page]).per(12)
 end

 def show
  @item_list = ItemList.find(params[:id])
  @item_list_comment = ItemListComment.new
 end

 def edit
  @item_list = ItemList.find(params[:id])
 end

 def update
  @item_list = ItemList.find(params[:id])
  if @item_list.update(item_list_params)
   flash[:notice] = "You have updated post successfully."
   redirect_to item_list_path(@item_list.id)
  else
   render :edit
  end
 end

 def destroy
  @item_list = ItemList.find(params[:id])
  @item_list.destroy
  redirect_to item_lists_path
 end


 private

 def item_list_params
   params.require(:item_list).permit(:user_id, :genre_id, :item_name, :memo, :image)
 end
end
