class ItemListComment < ApplicationRecord

  belongs_to :user
  belongs_to :item_list

  validates :comment, presence: true
end
