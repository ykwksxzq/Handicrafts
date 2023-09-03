class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post_craft

  validates :comment, presence: true
end
