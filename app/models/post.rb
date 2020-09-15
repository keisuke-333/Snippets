class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :language, presence: true
  validates :code, presence: true

  belongs_to :user
  has_many :favorites, :dependent => :destroy

  is_impressionable

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
