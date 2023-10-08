class WishList < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  validates :item_name, presence: true, length: { maximum: 20 }
  validates :memo, length: { maximum: 60 }

end
