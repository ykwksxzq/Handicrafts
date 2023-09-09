class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_crafts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :item_lists, dependent: :destroy
  has_many :item_list_comments, dependent: :destroy
  has_many :item_favorites, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width,height)
   unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
   end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def unsubscribe
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要

      user.nick_name = "ゲスト"
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

end
