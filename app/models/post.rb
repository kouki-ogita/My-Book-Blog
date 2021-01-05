class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 3000 }

  belongs_to :user
  has_many :likes
  has_many :reverses_of_like, class_name: 'Like', foreign_key: 'post_id', dependent: :destroy
  has_many :favoriteds, through: :reverses_of_like, source: :user
  
  has_many :comments, dependent: :destroy
end
