class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  mount_uploader :image, ImageUploader

  has_many :posts, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def remember_me
    true
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.profile = "このユーザーは閲覧用のゲストユーザーです。プロフィール更新やアカウント削除をすることはできません。"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
