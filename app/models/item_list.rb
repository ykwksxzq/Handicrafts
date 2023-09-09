class ItemList < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :genre
  has_many :item_list_comments, dependent: :destroy
  has_many :item_favorites, dependent: :destroy

 def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
 end




  def item_favorited_by?(user)
    item_favorites.exists?(user_id: user.id)
  end

end
