class Public::GenresController < ApplicationController

 def index
  @post_crafts = PostCraft.published.page(params[:page]).per(12)
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @post_crafts = @genre.post_crafts
      @post_crafts = @post_crafts.published.page(params[:page]).per(12)
    end
 end

 private

 def genre_rarams
    params.require(:genre).permit(:name)
 end
end
