class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :language, presence: true
  validates :code, presence: true

  belongs_to :user
  has_many :favorites, :dependent => :destroy
  has_many :favorited_users, through: :favorites, source: :user

  is_impressionable counter_cache: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
