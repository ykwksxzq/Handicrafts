class PostCraft < ApplicationRecord

  enum status: { published: 0, draft: 1 }

  has_one_attached :image

  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 100 }


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(query)
    where("title LIKE ? OR introduction LIKE ?", "%#{query}%", "%#{query}%")
  end

  acts_as_taggable_on :tags

end
