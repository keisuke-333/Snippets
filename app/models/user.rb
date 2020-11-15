class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  validates :profile, length: { maximum: 200 }
  mount_uploader :image, ImageUploader

  has_many :posts, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, :dependent => :destroy
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, :dependent => :destroy
  has_many :followers, through: :passive_relationships, source: :following

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
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
