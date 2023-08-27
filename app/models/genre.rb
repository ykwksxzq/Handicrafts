class Genre < ApplicationRecord

  has_many :post_crafts

  validates :name, presence: true
end
