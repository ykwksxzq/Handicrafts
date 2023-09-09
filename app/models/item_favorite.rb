class ItemFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :item_list

end
