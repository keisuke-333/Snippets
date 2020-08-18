class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :language, presence: true
  validates :code, presence: true
end
