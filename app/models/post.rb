class Post < ApplicationRecord
  enum language: { HTML: 0, CSS: 1, JavaScript: 2, Ruby: 3, PHP: 4, SQL: 5, Git: 6 }
  validates :title, presence: true, length: { maximum: TITLE_MAXIMUM_LENGTH = 50 }
  validates :language, presence: true
  validates :code, presence: true

  belongs_to :user
  has_many :favorites, :dependent => :destroy
  has_many :favorited_users, through: :favorites, source: :user

  is_impressionable counter_cache: true

  TRUNCATE_TITLE_LENGTH = 40

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  ransacker :favorites_count do
    query = "(SELECT COUNT(*) FROM favorites where favorites.post_id = posts.id)"
    Arel.sql(query)
  end
end
