class Genre < ApplicationRecord

  has_many :post_crafts
  has_many :item_lists
  has_many :wish_lists

  scope :only_active, -> { where(status: true) }

  validates :name, presence: true
end
